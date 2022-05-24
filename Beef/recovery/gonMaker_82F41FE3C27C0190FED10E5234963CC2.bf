using System;
using System.Collections;
namespace gon_Utils
{
	class gonMaker
	{
		public List<IGonObj> objects;

		///Create a Gon String out of the object
		public void Create(String StrBuffer)
		{
			Gon.[Friend]depth++;
			for(IGonObj o in objects)
			{
				for(int a < Gon.[Friend]depth)
					StrBuffer.Append(" ");

				o.ToGonString(StrBuffer);

			}
			Gon.[Friend]depth--;

		}

		public this()
		{
			objects = new .();
		}
		public ~this()
		{
			delete objects;
		}

		public void AddToggle(String name, bool value) => objects.Add(gon_toggle(name,value));
		public void AddNumber(String name, double value) => objects.Add(gon_number(name,value));
		public void AddString(String name, String value) => objects.Add(gon_string(name,value));
		public void AddText(String name, String value) => objects.Add(gon_text(name,value));
		public void AddData(String name, String value) => objects.Add(gon_data(name,value));
		public void AddCustom(String type ,String name, String value) => objects.Add(gon_custom(type,name,value));
		public void AddObject(String name, gonMaker value) => objects.Add(gonObjectMaker(name,value));







	}
}

static
{
	struct gonObjectMaker : gon_Utils.IGonObj
	{
		public String name;
		public gon_Utils.gonMaker object;
		public void ToGonString(String StrBuffer)
		{
			Gon.[Friend]depth++;
			object.Create(StrBuffer);
			Gon.[Friend]depth--;
		}

		public this(String name, gon_Utils.gonMaker value)
		{
			this.name = name;
			this.object = value;
		}
	}
}