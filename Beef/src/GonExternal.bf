using System;
static
{
	extension Gon
	{
		private static int depth = -1; //Technically this removes threaded execution of the too string functions
		///outputs a debug string version of this gon object
	   	public override void ToString(String StrBuffer)
		{
			depth++;
			for((GonEntryType,int) i in Ordered)
			{
				for(int a < depth)
					StrBuffer.Append(" ");
				switch(i.0)
				{
				case .Toggle:
					StrBuffer.Append(gon_toggle_l[i.1].ToString(.. scope .()));
				case .Number:
					StrBuffer.Append(gon_number_l[i.1].ToString(.. scope .()));
				case .String:
					StrBuffer.Append(gon_string_l[i.1].ToString(.. scope .()));
				case .Text:
					StrBuffer.Append(gon_text_l[i.1].ToString(.. scope .()));
				case .Data:
					StrBuffer.Append(gon_data_l[i.1].ToString(.. scope .()));
				case .Custom:
					StrBuffer.Append(gon_custom_l[i.1].ToString(.. scope .()));
				case .Object:
					StrBuffer.Append(gon_object_l[i.1].ToString(.. scope .()));
				}

				StrBuffer.Append('\n');

				if(i.0 == .Object)
				{
					for(int a < depth)
						StrBuffer.Append(" ");
					StrBuffer.Append("}\n");
				}
			}
			depth--;
			StrBuffer.RemoveFromEnd(1);
		}
		///outputs the string that would result in this gon object
		public void ToGonString(String StrBuffer)
		{
			depth++;
			for((GonEntryType,int) i in Ordered)
			{
				for(int a < depth)
					StrBuffer.Append(" ");
				switch(i.0)
				{
				case .Toggle:
					StrBuffer.Append(gon_toggle_l[i.1].ToGonString(.. scope .()));
				case .Number:
					StrBuffer.Append(gon_number_l[i.1].ToGonString(.. scope .()));
				case .String:
					StrBuffer.Append(gon_string_l[i.1].ToGonString(.. scope .()));
				case .Text:
					StrBuffer.Append(gon_text_l[i.1].ToGonString(.. scope .()));
				case .Data:
					StrBuffer.Append(gon_data_l[i.1].ToGonString(.. scope .()));
				case .Custom:
					StrBuffer.Append(gon_custom_l[i.1].ToGonString(.. scope .()));
				case .Object:
					StrBuffer.Append(gon_object_l[i.1].ToGonString(.. scope .()));
				}

				StrBuffer.Append('\n');

				
			}
			depth--;

			if(depth == -1)
				StrBuffer.RemoveFromEnd(1);
		}
		[Warn("Gon allows multiple key, json doesnt, the generated string may be invalid")]
		///outputs a json string that returns an object thats similar to this one
		public void ToJSON(String StrBuffer, bool brackets = false)
		{
			if(brackets)
			{
				for(int a < depth)
					StrBuffer.Append(" ");
				StrBuffer.Append("{\n");
			}
			depth++;
			for((GonEntryType,int) i in Ordered)
			{
				for(int a < depth)
					StrBuffer.Append(" ");
				switch(i.0)
				{
				case .Toggle:
					StrBuffer.Append(gon_toggle_l[i.1].ToJSON(.. scope .()));
				case .Number:
					StrBuffer.Append(gon_number_l[i.1].ToJSON(.. scope .()));
				case .String:
					StrBuffer.Append(gon_string_l[i.1].ToJSON(.. scope .()));
				case .Text:
					StrBuffer.Append(gon_text_l[i.1].ToJSON(.. scope .()));
				case .Data:
					StrBuffer.Append(gon_data_l[i.1].ToJSON(.. scope .()));
				case .Custom:
					StrBuffer.Append(gon_custom_l[i.1].ToJSON(.. scope .()));
				case .Object:
					StrBuffer.Append(gon_object_l[i.1].ToJSON(.. scope .()));
				}

				StrBuffer.Append(",\n");

				
			}
			depth--;
			StrBuffer.RemoveFromEnd(2);
			if(brackets)
				StrBuffer.Append("\n}");
		
		}
	}
}