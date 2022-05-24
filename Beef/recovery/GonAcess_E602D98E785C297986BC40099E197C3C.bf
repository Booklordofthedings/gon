using System;
using System.Collections;
using gon_Utils;
static
{
	extension Gon
	{
		[Warn("May error if the index is out of bounds")]
		public (String,gonEntry) getIndex(int Index)
		{
			return this[Index];
		}
		[Warn("Errors if the name isnt found")]
		public gonEntry getFirstName(String name)
		{
			return this[name];
		}

		///Get the first object of type toggle with the given name or returns the fallback value
		public gon_toggle getToggle(String name, bool fallback)
		{
			for(gon_toggle i in gon_toggle_l)
				if(i.name == name)
					return i;
			gon_toggle t;
			t.name = name;
			t.value = fallback;

			return t;
		}
		///Tries to get the first object of type toggle with the given name
		public Result<gon_toggle> TryGetToggle(String name)
		{
			for(gon_toggle i in gon_toggle_l)
				if(i.name == name)
					return i;
			return .Err;
		}

		///Get the first object of type number with the given name or returns the fallback value
		public gon_number getNumber(String name, double fallback)
		{
			for(gon_number i in gon_number_l)
				if(i.name == name)
					return i;
			gon_number t;
			t.name = name;
			t.value = fallback;
			return t;
		}
		///Tries to get the first object of type number with the given name
		public Result<gon_number> TryGetNumber(String name)
		{
			for(gon_number i in gon_number_l)
				if(i.name == name)
					return i;

			return .Err;
		}

		///Get the first object of type toggle with the given name or returns the fallback value
		public gon_string getString(String name, String fallback)
		{
			for(gon_string i in gon_string_l)
				if(i.name == name)
					return i;

			gon_string t;
			t.name = name;
			t.value = fallback;
			return t;
		}
		///Tries to get the first object of type string with the given name
		public Result<gon_string> TryGetString(String name)
		{
			for(gon_string i in gon_string_l)
				if(i.name == name)
					return i;

			return .Err;
		}

		///Get the first object of type text with the given name or returns the fallback value
		public gon_text getText(String name, String fallback)
		{
			for(gon_text i in gon_text_l)
				if(i.name == name)
					return i;

			gon_text t;
			t.name = name;
			t.value = fallback;
			return t;
		}
		///Tries to get the first object of type text with the given name
		public Result<gon_text> TryGetText(String name)
		{
			for(gon_text i in gon_text_l)
				if(i.name == name)
					return i;

			return .Err;
		}

		///Get the first object of type data with the given name or returns the fallback value
		public gon_data getData(String name, String fallback)
		{
			for(gon_data i in gon_data_l)
				if(i.name == name)
					return i;

			gon_data t;
			t.name = name;
			t.value = fallback;
			return t;
		}
		///Tries to get the first object of type data with the given name
		public Result<gon_data> TryGetData(String name)
		{
			for(gon_data i in gon_data_l)
				if(i.name == name)
					return i;

			return .Err;
		}

		///Get the first object of type custom with the given name or returns the fallback value
		public gon_custom getCustom(String name, String fallbackType,String fallback)
		{
			for(gon_custom i in gon_custom_l)
				if(i.name == name)
					return i;

			gon_custom t;
			t.name = name;
			t.value = fallback;
			t.type = fallbackType;
			return t;
		}
		///Tries to get the first object of type custom with the given name
		public Result<gon_custom> TryGetCustom(String name,String type)
		{
			for(gon_custom i in gon_custom_l)
				if(i.name == name)
					if(i.type == type)
						return i;

			return .Err;
		}

		///Get the first object of type object with the given name or returns the fallback value
		public gon_object getObject(String name, Gon fallback)
		{
			for(gon_object i in gon_object_l)
				if(i.name == name)
					return i;

			gon_object t;
			t.name = name;
			t.value = fallback;
			return t;
		}
		///Tries to get the first object of type object with the given name
		public Result<gon_object> TryGetObject(String name)
		{
			for(gon_object i in gon_object_l)
				if(i.name == name)
					return i;

			return .Err;
		}

		//TODO:Masking
#region search

		//Search the current gon object for objects of a given type
		public List<T> Search<T>() where T : gon_toggle
		{
			List<T> L = new .();
			
			for(var i in Ordered)
				if(i.0 == .Toggle)
					L.Add(gon_toggle_l[i.1]);
			return L;
		}

		//Search the current gon object for objects of a given type
		public List<T> Search<T>() where T : gon_number
		{
			List<T> L = new .();
			for(var i in Ordered)
				if(i.0 == .Number)
					L.Add(gon_number_l[i.1]);
			
			return L;
		}

		//Search the current gon object for objects of a given type
		public List<T> Search<T>() where T : gon_string
		{
			List<T> L = new .();
			for(var i in Ordered)
				if(i.0 == .String)
					L.Add(gon_string_l[i.1]);
			return L;
		}

		//Search the current gon object for objects of a given type
		public List<T> Search<T>() where T : gon_text
		{
			List<T> L = new .();
			for(var i in Ordered)
				if(i.0 == .Text)
					L.Add(gon_text_l[i.1]);
			
			return L;
		}

		//Search the current gon object for objects of a given type
		public List<T> Search<T>() where T : gon_data
		{
			List<T> L = new .();
			for(var i in Ordered)
				if(i.0 == .Data)
					L.Add(gon_data_l[i.1]);
			
			return L;
		}

		//Search the current gon object for objects of a given type
		public List<T> Search<T>() where T : gon_custom
		{
			List<T> L = new .();
			for(var i in Ordered)
				if(i.0 == .Custom)
					L.Add(gon_custom_l[i.1]);
			return L;
		}

		//Search the current gon object for objects of a given type
		public List<T> Search<T>() where T : gon_object
		{
			List<T> L = new .();
			for(var i in Ordered)
				if(i.0 == .Text)
					L.Add(gon_object_l[i.1]);
			
			return L;
		}
#endregion
		#region search

		//Search the current gon object for objects of a given type
		public List<T> Search<T>(String name) where T : gon_toggle
		{
			List<T> L = new .();
			for(var i in Ordered)
				if(i.0 == .Toggle)
					if(gon_toggle_l[i.1].name == name)
						L.Add(gon_toggle_l[i.1]);
			return L;
		}

		//Search the current gon object for objects of a given type
		public List<T> Search<T>(String name) where T : gon_number
		{
			List<T> L = new .();
			for(var i in Ordered)
				if(i.0 == .Number)
					if(gon_number_l[i.1].name == name)
						L.Add(gon_number_l[i.1]);
			
			return L;
		}

		//Search the current gon object for objects of a given type
		public List<T> Search<T>(String name) where T : gon_string
		{
			List<T> L = new .();
			for(var i in Ordered)
				if(i.0 == .String)
					if(gon_string_l[i.1].name == name)
						L.Add(gon_string_l[i.1]);
			return L;
		}

		//Search the current gon object for objects of a given type
		public List<T> Search<T>(String name) where T : gon_text
		{
			List<T> L = new .();
			for(var i in Ordered)
				if(i.0 == .Text)
					if(gon_text_l[i.1].name == name)
						L.Add(gon_text_l[i.1]);
			
			return L;
		}

		//Search the current gon object for objects of a given type
		public List<T> Search<T>(String name) where T : gon_data
		{
			List<T> L = new .();
			for(var i in Ordered)
				if(i.0 == .Data)
					if(gon_data_l[i.1].name == name)
						L.Add(gon_data_l[i.1]);
			
			return L;
		}

		//Search the current gon object for objects of a given type
		public List<T> Search<T>(String name) where T : gon_custom
		{
			List<T> L = new .();
			for(var i in Ordered)
				if(i.0 == .Custom)
					if(gon_custom_l[i.1].name == name)
						L.Add(gon_custom_l[i.1]);
			return L;
		}

		//Search the current gon object for objects of a given type
		public List<T> Search<T>(String name) where T : gon_object
		{
			List<T> L = new .();
			for(var i in Ordered)
				if(i.0 == .Text)
					if(gon_object_l[i.1].name == name)
						L.Add(gon_object_l[i.1]);
			
			return L;
		}

	
#endregion


		public List<gonEntry> Search(String name)
		{
		   List<gonEntry> L = new .();
			for(var e in Ordered)
			{
				switch(e.0)
				{
				case .Toggle:
					if(gon_toggle_l[e.1].name == name)
						L.Add( new .(e.0,gon_toggle_l[e.1].value));
				case .Number:
					if(gon_number_l[e.1].name == name)
						L.Add( new .(e.0,null,gon_number_l[e.1].value));
				case .String:
					if(gon_string_l[e.1].name == name)
					L.Add( new .(e.0,null,null,gon_string_l[e.1].value));
				case .Text:
					if(gon_text_l[e.1].name == name)
					L.Add( new .(e.0,null,null,gon_text_l[e.1].value));
				case .Data:
					if(gon_data_l[e.1].name == name)
					L.Add( new .(e.0,null,null,gon_data_l[e.1].value));
				case .Custom:
					if(gon_custom_l[e.1].name == name)
					L.Add( new .(e.0,null,null,gon_custom_l[e.1].value));
				case .Object:
					if(gon_object_l[e.1].name == name)
					L.Add( new .(e.0,null,null,null,gon_object_l[e.1].value));
				}
			}
			return L;
		}
	}
}