using System;
using System.Collections;
using gon_Utils;
static
{
	class Gon : IEnumerable<gonEntry>
	{
		String name = new String("base");
		List<(GonEntryType,int)> Ordered; //This is used to enumerate objects in order 1= type 2 = index in that specific list

		//The actual lines being stored here
		List<gon_string> gon_string_l;
		List<gon_text> gon_text_l;
		List<gon_number> gon_number_l;
		List<gon_toggle> gon_toggle_l;
		List<gon_data> gon_data_l;
		List<gon_custom> gon_custom_l;
		List<gon_object> gon_object_l;

		private bool isInit = false;
		//Initialize all data for usage
		private void Initialize()
		{
			gon_string_l = new .();
			gon_text_l = new .();
			gon_number_l = new .();
			gon_toggle_l = new .();
			gon_data_l = new .();
			gon_custom_l = new .();
			gon_object_l = new .();
			Ordered = new .();
		}
		///Returns the type according to the gon notation convention or errors if line is invalid
		private Result<String> _getType(StringView v)
		{
			int start = -1;
			int end = -1;
			L: for(int i = 0; i < v.Length; i++)
			{
				if(v[i].IsWhiteSpace) //At the start of the line there may be whitespaces we ignore
					continue;

				if(start < 0 && v[i] == ':') //No type is given
					return .Err;

				if(start < 0 && v[i] == '/') //The line is a comment
					return .Err;

				if(start < 0) //Start of the string
					start = i;

				if(v[i] == ':') //Found the end of the typename
				{
					end = i;
					break L;
				}	
			}
			if(start >= 0 && end > 0)
				return new String(v,start,end - start); //Return the finished string
				

			return .Err; //Nothing suitable was found
		}
		///Returns information on wether the string is a valid string based on the given type
		private Result<int> _Validate(StringView v, String t)
		{
			int first = v.IndexOf(":");
			if(first < 0)
				return .Err; //No : found (this shouldnt happen)
			first = v.IndexOf(":",first+1);
			if(first < 0)
				if(t == "o" || t == "O")
					return .Ok(-1);	//An object only needs one :
				else
					return .Err; //Its not an object so we error
			
			return .Ok(first); //returns the index of the name / data difference
		}

		public this()
		{
			Initialize();
			isInit = true;
		}
		public this(String n)
		{
			Initialize();
			isInit = true;
			delete this.name;
			this.name = new .(n);
		}
		public ~this()
		{
			for(var v in gon_string_l)
			{
				delete v.name;
				delete v.value;
			}
		   	delete gon_string_l;
			for(var v in gon_text_l)
			{
				delete v.name;
				delete v.value;
			}
			delete gon_text_l;
			for(var v in gon_number_l)
				delete v.name;
			delete gon_number_l;
			for(var v in gon_toggle_l)
				delete v.name;
			delete gon_toggle_l;
			for(var v in gon_data_l)
			{
				delete v.name;
				delete v.value;
			}
			delete gon_data_l;
			for(var v in gon_custom_l)
			{
				delete v.name;
				delete v.value;
				delete v.type;
			}
			delete gon_custom_l;
			for(var v in gon_object_l)
			{
				delete v.name;
				delete v.value;
			}
			delete gon_object_l;
			delete Ordered;
			delete name;
		}
		private void _ParseGon(ref StringSplitEnumerator Split)
		{
			L :for(StringView s in Split)
			{
				Result<String> t = _getType(s);//Returns the type of the object
				if(t case .Err)
					continue L; //Nextline

				//WARN: If the string in t has been deleted this will fatal error
				Result<int> v = _Validate(s,t.Value); //If v == error invalid
				if(v case .Err)
					continue L;

				if(t.Value == "s") //Simple one line string
				{
					gon_string current; //Create object
					int start = s.IndexOf(':'); //Get start of name
					current.name = new .(StringView(s,start+1,v.Value - start-1));
					current.value = new .(StringView(s,v.Value+1)); //Parse name and value
					gon_string_l.Add(current); //Add object to thing
					int c = gon_string_l.Count - 1;
					Ordered.Add((.String,c)); //Add object to ordered queue
					delete t.Value; //Cleanup t;
					continue L;
				}
				else if(t.Value == "n") //Number
				{
					gon_number current; //Create object
					int start = s.IndexOf(':'); //Get start of name
					current.name = new .(StringView(s,start+1,v.Value - start-1));
					if(double.Parse(StringView(s,v.Value+1)) case .Ok(double val))
						current.value = val; //Parse name and value
					else
					{
						delete current.name;
						continue L;
					}
					gon_number_l.Add(current); //Add object to thing
					int c = gon_number_l.Count - 1;
					Ordered.Add((.Number,c)); //Add object to ordered queue
					delete t.Value; //Cleanup t;
					continue L;
				}
				else if(t.Value == "b") //Booleans
				{
					gon_toggle current; //Create object
					int start = s.IndexOf(':'); //Get start of name
					current.name = new .(StringView(s,start+1,v.Value - start-1));
					if(bool.Parse(StringView(s,v.Value+1)) case .Ok(bool val))
						current.value = val; //Parse name and value
					else
					{
						delete current.name;
						continue L;
					}
					gon_toggle_l.Add(current); //Add object to thing
					int c = gon_toggle_l.Count - 1;
					Ordered.Add((.Toggle,c)); //Add object to ordered queue
					delete t.Value; //Cleanup t;
					continue L;
				}
				else if(t.Value == "t") //multiple lines of text
				{
					gon_text current; //Create object
					int start = s.IndexOf(':'); //Get start of name
					current.name = new .(StringView(s,start+1,v.Value - start-1));
					Result<uint,UInt.ParseError> length = uint.Parse(StringView(s,v.Value+1));
					if(length case .Err)
					{
						delete current.name;
						continue L;
					}
					String values = new .();

					for(uint i < length.Value)
					{
						bool works = Split.MoveNext();
						if(!works)
							continue L;

						values.Append(Split.Current);
						if(i+1 < length.Value)
							values.Append('\n');

					}
					current.value = values;
					gon_text_l.Add(current); //Add object to thing
					int c = gon_text_l.Count - 1;
					Ordered.Add((.Text,c)); //Add object to ordered queue
					delete t.Value; //Cleanup t;
					continue L;
				}
				else if(t.Value == "d") //multiple lines of data
				{
					gon_data current; //Create object
					int start = s.IndexOf(':'); //Get start of name
					current.name = new .(StringView(s,start+1,v.Value - start-1));
					Result<uint,UInt.ParseError> length = uint.Parse(StringView(s,v.Value+1));
					if(length case .Err)
					{
						delete current.name;
						continue L;
					}
					String values = new .();

					for(uint i < length.Value)
					{
						bool works = Split.MoveNext();
						if(!works)
							continue L;

						values.Append(Split.Current);
						if(i+1 < length.Value)
							values.Append('\n');

					}
					current.value = values;
					gon_data_l.Add(current); //Add object to thing
					int c = gon_data_l.Count - 1;
					Ordered.Add((.Data,c)); //Add object to ordered queue
					delete t.Value; //Cleanup t;
					continue L;
				}
				else if(t.Value == "o") //object start
				{
					gon_object current; //Create object
					int start = s.IndexOf(':'); //Get start of name
					current.name = new .(StringView(s,start+1,s.Length-(start+1)));
					current.value = new Gon(current.name);
					current.value._ParseGon(ref Split);
					gon_object_l.Add(current); //Add object to thing
					int c = gon_object_l.Count - 1;
					Ordered.Add((.Object,c)); //Add object to ordered queue
					delete t.Value; //Cleanup t;
					continue L;
				}
				else if(t.Value == "O") //object start
				{
					int start = s.IndexOf(':'); //Get start of name
					String n = new .(StringView(s,start+1,s.Length-(start+1)));
					if(n == name)
					{
						delete n;
						delete t.Value;
						return;
					}
					
				}
				else  //Custom object
				{
					gon_custom current; //Create object
					int start = s.IndexOf(':'); //Get start of name
					current.name = new .(StringView(s,start+1,v.Value - start-1));
					current.value = new .(StringView(s,v.Value+1)); //Parse name and value
					current.type = new .(t.Value);
					gon_custom_l.Add(current); //Add object to thing
					int c = gon_custom_l.Count - 1;
					Ordered.Add((.Custom,c)); //Add object to ordered queue
					delete t.Value; //Cleanup t;
					continue L;
				}
			}
		}

		///Parses the input string to a gon and adds it to the object 
		public void Parse(String Input)
		{
			if(!isInit)
				Initialize();
			isInit = true;

			StringSplitEnumerator Split = Input.Split('\n'); //Divide object up by lines
			_ParseGon(ref Split);
		}

#region acess
		//Everything a user needs to acess from the object
		public int Count
		{
			get
			{
				return Ordered.Count;
			}
		}

		public (String,gonEntry) this[int number]
		{
			get
			{
				if(number >= Ordered.Count)
					Runtime.FatalError("Out of range error");

				(GonEntryType,int) entry = Ordered[number];

				switch(entry.0)
				{
				case .Toggle:
					return (gon_toggle_l[entry.1].name, new .(entry.0,gon_toggle_l[entry.1].value));
				case .Number:
					return (gon_number_l[entry.1].name, new .(entry.0,null,gon_number_l[entry.1].value));
				case .String:
					return (gon_string_l[entry.1].name, new .(entry.0,null,null,gon_string_l[entry.1].value));
				case .Text:
					return (gon_text_l[entry.1].name, new .(entry.0,null,null,gon_text_l[entry.1].value));
				case .Data:
					return (gon_data_l[entry.1].name, new .(entry.0,null,null,gon_data_l[entry.1].value));
				case .Custom:
					return (gon_custom_l[entry.1].name, new .(entry.0,null,null,gon_custom_l[entry.1].value));
				case .Object:
					return (gon_object_l[entry.1].name, new .(entry.0,null,null,null,gon_object_l[entry.1].value));
				}

			}
			
		}

		public gonEntry this[String name]
		{
			get
			{
				for((GonEntryType,int) e in Ordered)
				{
					switch(e.0)
					{
					case .Toggle:
						if(gon_toggle_l[e.1].name == name)
							return new .(e.0,gon_toggle_l[e.1].value);
					case .Number:
						if(gon_number_l[e.1].name == name)
							return new .(e.0,null,gon_number_l[e.1].value);
					case .String:
						if(gon_string_l[e.1].name == name)
						return new .(e.0,null,null,gon_string_l[e.1].value);
					case .Text:
						if(gon_text_l[e.1].name == name)
						return new .(e.0,null,null,gon_text_l[e.1].value);
					case .Data:
						if(gon_data_l[e.1].name == name)
						return new .(e.0,null,null,gon_data_l[e.1].value);
					case .Custom:
						if(gon_custom_l[e.1].name == name)
						return new .(e.0,null,null,gon_custom_l[e.1].value);
					case .Object:
						if(gon_object_l[e.1].name == name)
						return new .(e.0,null,null,null,gon_object_l[e.1].value);
					}
				}
				Runtime.FatalError("Name not found error");	
			}
		}

		

		public gonEnumerator GetEnumerator()
		{
			return .(&this);
		}
#endregion

	
		
	}
	enum GonEntryType : int8 //The possible types of gon objcts
	{
		String, //done
		Text,
		Toggle, //done
		Number, //done
		Custom, //done
		Object,
		Data
	}

#region structs
	struct gon_number : IGonObj
	{
		public String name;
		public double value;
		public this(String name, double value)
		{
			this.name = name;
			this.value = value;
		}
		public void ToString(String buffer)
		{
			buffer.Append(name);
			buffer.Append(" = ");
			buffer.Append(value.ToString(.. scope String()));
		}
		public void ToGonString(String buffer)
		{
			buffer.Append("n:");
			buffer.Append(name);
			buffer.Append(":");
			buffer.Append(value.ToString(.. scope String()));
		}
		public void ToJSON(String buffer)
		{
			buffer.Append('"');
			buffer.Append(name);
			buffer.Append('"');
			buffer.Append(':');
			buffer.Append(value.ToString(.. scope String()));
		}
	}
	struct gon_toggle : IGonObj
	{
		public String name;
		public bool value;

		public this(String name, bool value)
		{
			this.name = name;
			this.value = value;
		}

		public void ToString(String buffer)
		{
			buffer.Append(name);
			buffer.Append(" = ");
			buffer.Append(value.ToString(.. scope String()));
		}
		public void ToGonString(String buffer)
		{
			buffer.Append("t:");
			buffer.Append(name);
			buffer.Append(":");
			buffer.Append(value.ToString(.. scope String()));
		}
		public void ToJSON(String buffer)
		{
			buffer.Append('"');
			buffer.Append(name);
			buffer.Append('"');
			buffer.Append(':');
			if(value == true)
				buffer.Append("true");
			else
				buffer.Append("false");
		}
	}
	struct gon_string : IGonObj
	{
		public String name;
		public String value;

		public this(String name, String value)
		{
			this.name = name;
			this.value = value;
		}

		public void ToString(String buffer)
		{
			buffer.Append(name);
			buffer.Append(" = ");
			buffer.Append(value);
		}
		public void ToGonString(String buffer)
		{
			buffer.Append("s:");
			buffer.Append(name);
			buffer.Append(":");
			buffer.Append(value);
		}
		public void ToJSON(String buffer)
		{
			buffer.Append('"');
			buffer.Append(name);
			buffer.Append('"');
			buffer.Append(':');
			buffer.Append('"');
			buffer.Append(value);
			buffer.Append('"');
		}
	}
	struct gon_custom : IGonObj
	{
		public String name;
		public String value;
		public String type;

		public this(String type,String name, String value)
		{
			this.name = name;
			this.value = value;
			this.type = type;
		}

		public void ToString(String buffer)
		{
			
			buffer.Append(name);
			buffer.Append(" = ");
			buffer.Append(type);
			buffer.Append(":");
			buffer.Append(value);
		}
		public void ToGonString(String buffer)
		{
			buffer.Append("c:");
			buffer.Append(type);
			buffer.Append(":");
			buffer.Append(name);
			buffer.Append(":");
			buffer.Append(value);
		}
		public void ToJSON(String buffer)
		{
			buffer.Append('"');
			buffer.Append(name);
			buffer.Append('"');
			buffer.Append(':');
			buffer.Append('"');
			buffer.Append(type);
			buffer.Append(":");
			buffer.Append(value);
			buffer.Append('"');
		}

	}
	struct gon_text : IGonObj
	{
		public String name;
		public String value;

		public this(String name, String value)
		{
			this.name = name;
			this.value = value;
		}

		public void ToString(String buffer)
		{
			buffer.Append(name);
			buffer.Append(" = ");
			buffer.Append(value.Quote(.. scope .()));
		}
		public void ToGonString(String buffer)
		{
			buffer.Append("t:");
			buffer.Append(name);
			buffer.Append(":");
			buffer.Append(value.Quote(.. scope .()));
		}
		public void ToJSON(String buffer)
		{
			buffer.Append('"');
			buffer.Append(name);
			buffer.Append('"');
			buffer.Append(':');
			buffer.Append(value.Quote(.. scope .()));
		}
	}
	struct gon_object : IGonObj
	{
		public String name;
		public Gon value;

		public void ToString(String buffer)
		{
			buffer.Append(name);
			buffer.Append(" = \n");
			buffer.Append(value.ToString(.. scope .()));
		}
		public void ToGonString(String buffer)
		{
			buffer.Append("o:");
			buffer.Append(name);
			buffer.Append('\n');
			buffer.Append(value.ToGonString(.. scope .()));
				for(int a < Gon.[Friend]depth)
					buffer.Append(" ");
			buffer.Append("O:");
			buffer.Append(name);
		}
		public void ToJSON(String buffer)
		{
			buffer.Append('"');
			buffer.Append(name);
			buffer.Append('"');
			buffer.Append(':');
			buffer.Append('{');
			buffer.Append('\n');
			buffer.Append(value.ToJSON(.. scope .()));
			buffer.Append('\n');
			for(int a < Gon.[Friend]depth)
					buffer.Append(" ");
			buffer.Append('}');

		}
	}
	struct gon_data : IGonObj
	{
		public String name;
		public String value;

		public this(String name, String value)
		{
			this.name = name;
			this.value = value;
		}

		public void ToString(String buffer) => buffer.Append($"{name} = {value.Quote(.. scope .())}");
		public void ToGonString(String buffer) => buffer.Append($"d:{name}:{value.Quote(.. scope .())}");
		public void ToJSON(String buffer) =>  buffer.Append($"\"{name}\":{value.Quote(.. scope .())}");

		
	}
#endregion
}