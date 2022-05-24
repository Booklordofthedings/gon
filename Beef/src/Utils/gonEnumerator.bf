using System;
using System.Collections;
namespace gon_Utils
{
	struct gonEnumerator : IEnumerator<gonEntry>
	{
		int iterator = 0;
		Gon* object;
		public this(Gon* g)
		{
			object = g;
		}
		public Result<gonEntry> IEnumerator<gonEntry>.GetNext() mut
		{
			if(iterator + 1 < (*object).[Friend]Ordered.Count)
			{
				iterator++;
				switch ((*object).[Friend]Ordered[iterator].0) 
				{
				case .Toggle:
					return .Ok(new .(.Toggle, (*object).[Friend]gon_toggle_l[(*object).[Friend]Ordered[iterator].1].value));
				case .Number:
					return .Ok(new .(.Number,null, (*object).[Friend]gon_number_l[(*object).[Friend]Ordered[iterator].1].value));
				case .String:
					return .Ok(new .(.String,null,null, (*object).[Friend]gon_string_l[(*object).[Friend]Ordered[iterator].1].value));
				case .Text:
					return .Ok(new .(.Text,null,null, (*object).[Friend]gon_text_l[(*object).[Friend]Ordered[iterator].1].value));
				case .Data:
					 return .Ok(new .(.Data,null,null, (*object).[Friend]gon_data_l[(*object).[Friend]Ordered[iterator].1].value));
				case .Custom:
					return .Ok(new .(.Custom,null,null,(*object).[Friend]gon_custom_l[(*object).[Friend]Ordered[iterator].1].value));
				case .Object:
					return .Ok(new .(.Object,null,null,null,(*object).[Friend]gon_object_l[(*object).[Friend]Ordered[iterator].1].value));
				}
				
			}
			return .Err;
		}
	}
}