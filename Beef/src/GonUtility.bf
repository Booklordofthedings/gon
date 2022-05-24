using System;
using gon_Utils;
static
{
	extension Gon
	{
		//Indexof
#region contains
		///Check wether an object of the given name and type exist in the object
		public bool Contains(String name, GonEntryType type)
		{
			for(var i in Ordered)
 			{
				 if(i.0 == type)
				 {
					 switch(i.0)
					 {
						 case .Toggle:
						 if(gon_toggle_l[i.1].name == name)
							 return true;
						 case .Number:
						 if(gon_number_l[i.1].name == name)
							return true;
						 case .String:
						 if(gon_string_l[i.1].name == name)
							return true;
						 case .Text:
						 if(gon_text_l[i.1].name == name)
							return true;
						 case .Data:
						 if(gon_data_l[i.1].name == name)
							return true;
						 case .Custom:
						 if(gon_custom_l[i.1].name == name)
							return true;
						 case .Object:
						 if(gon_object_l[i.1].name == name)
							return true;
					}
				}
			}
			return false;
		}


		//public bool containsToggle()
#endregion
		public void Clear()
		{
			for(var v in gon_string_l)
			{
				delete v.name;
				delete v.value;
			}
			gon_string_l.Clear();
			for(var v in gon_text_l)
			{
				delete v.name;
				delete v.value;
			}
			gon_text_l.Clear();
			for(var v in gon_number_l)
				delete v.name;
			gon_number_l.Clear();
			for(var v in gon_toggle_l)
				delete v.name;
			gon_toggle_l.Clear();
			for(var v in gon_data_l)
			{
				delete v.name;
				delete v.value;
			}
			gon_data_l.Clear();
			for(var v in gon_custom_l)
			{
				delete v.name;
				delete v.value;
				delete v.type;
			}
			gon_custom_l.Clear();
			for(var v in gon_object_l)
			{
				delete v.name;
				delete v.value;
			}
			gon_object_l.Clear();
			Ordered.Clear();
			delete name;
			name = new String("base");
		}

		public enum GonSearchType : int8
		{
			Toggle,
			Number,
			String,
			Text,
			Data,
			Custom,
			Object,
			All
		}
		///An extended search function
		///@param name the name of the object
		///@param t the type of object you are looking for
		///@param indexStart the index from where it should start searching from
		///@param resultCount how many objects that fit this filter should be returned
		///@param maxDepth will recursivly look into objects to find fitting ones
		///@param instance will skip the first n objects taht fit
		public gonSearch SearchEx(GonSearchType t = .All, String name = "none", int indexStart = 0, int resultCount = 9999999, int maxDepth = 1,int instance = 0, String customT = "all")
		{
			var instance;
			var maxDepth;
			var resultCount;
			gonSearch result = new .();
			int results = 0;
			//Simple parameter checking
			if(indexStart < 0)
				return result.[Friend]SetError("parameter: indexStart has an invalid value");
			else if(resultCount < 1)
				return result.[Friend]SetError("parameter: resultCount has an invalid value");
			else if(maxDepth < 1)
				return result.[Friend]SetError("parameter: maxDepth has an invalid value");
			else if(instance < 0)
				return result.[Friend]SetError("parameter: instance has an invalid value");
			if(indexStart > Ordered.Count-1)
				return result.[Friend]SetError("starting index is too high");

			L:for(int i = indexStart; i < Ordered.Count; i++)
			{
			  if((int)Ordered[i].0 != (int8)t && t != .All)
					continue L;

				switch(Ordered[i].0)
				{
				case .Toggle:
					if(gon_toggle_l[Ordered[i].1].name == name || name == "none")
						if(instance == 0)
							if(resultCount >= 1)
							{
								result.Items.Add(new .(Ordered[i].1,gon_toggle_l[Ordered[i].1].name,gon_toggle_l[Ordered[i].1].value));
								resultCount--;
							}
							else
							{
								return result;
							}
					    else
							instance--;
				case .Number:
					if(gon_number_l[Ordered[i].1].name == name || name == "none")
						if(instance == 0)
							if(resultCount >= 1)
							{
								result.Items.Add(new .(Ordered[i].1,gon_number_l[Ordered[i].1].name,gon_number_l[Ordered[i].1].value));
								resultCount--;
							}
							else
							{
								return result;
							}
						else
							instance--;
				case .String:
					if(gon_string_l[Ordered[i].1].name == name || name == "none")
						if(instance == 0)
							if(resultCount >= 1)
							{
								result.Items.Add(new .(Ordered[i].1,gon_string_l[Ordered[i].1].name,gon_string_l[Ordered[i].1].value,.String));
								resultCount--;
							}
							else
							{
								return result;
							}
						else
							instance--;
				case .Text:
					if(gon_text_l[Ordered[i].1].name == name || name == "none")
						if(instance == 0)
							if(resultCount >= 1)
							{
								result.Items.Add(new .(Ordered[i].1,gon_text_l[Ordered[i].1].name,gon_text_l[Ordered[i].1].value,.Text));
								resultCount--;
							}
							else
							{
								return result;
							}
						else
							instance--;
				case .Data:
					if(gon_data_l[Ordered[i].1].name == name || name == "none")
						if(instance == 0)
							if(resultCount >= 1)
							{
								result.Items.Add(new .(Ordered[i].1,gon_data_l[Ordered[i].1].name,gon_data_l[Ordered[i].1].value,.Data));
								resultCount--;
							}
							else
							{
								return result;
							}
						else
							instance--;
				case .Custom:
					if((gon_custom_l[Ordered[i].1].name == name || name == "none") && (gon_custom_l[Ordered[i].1].type == customT || customT == "all"))
						if(instance == 0)
							if(resultCount >= 1)
							{
								result.Items.Add(new .(Ordered[i].1,gon_custom_l[Ordered[i].1].name,gon_custom_l[Ordered[i].1].type,gon_custom_l[Ordered[i].1].value));
								resultCount--;
							}
							else
							{
								return result;
							}
						else
							instance--;
				case .Object:
					if(gon_object_l[Ordered[i].1].name == name || name == "none")
						if(instance == 0)
							if(resultCount >= 1)
							{
								result.Items.Add(new .(Ordered[i].1,gon_object_l[Ordered[i].1].name,gon_object_l[Ordered[i].1].value));
								resultCount--;

								if(maxDepth > 1)
								{
									gonSearch depths = SearchEx(t,name,0,resultCount,maxDepth,instance);
									if(depths.Sucessfull)
										for(gon_Utils.gonSearchResult n in depths.Items)
											result.Items.Add(n);
									maxDepth--;
								}
							}
							else
							{
								return result;
							}
						else
							instance--;
				}
			}

			if(result.Items.Count == 0)
				return result.[Friend]SetError("No fitting object have been found");
			return result;
		}
	}

	
}