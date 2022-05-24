using System;
using System.Collections;
namespace gon_Utils
{
	class gonSearchResult
	{
		public int index;
		public String name;
		public GonEntryType type;

		private bool valBool;
		private double valNum;
		private Gon valGon;
		private String valString;
		private String typeName;

		public this(int i,String n,bool val, GonEntryType t = .Toggle)
		{
			index = i;
			name = n;
			type = .Toggle;
			valBool = val;
		}

		public this(int i, String n, double val, GonEntryType t = .Number)
		{
			index = i;
			name = n;
			type = .Number;
			valNum = val;
		}

		public this(int i, String n, Gon val, GonEntryType t = .Object)
		{
			index = i;
			name = n;
			type = .Object;
			valGon = val;
		}

		public this(int i, String n,String tn, String val, GonEntryType t = .Custom)
		{
			index = i;
			name = n;
			type = .C;
			valString = val;
			typeName = tn;
		}

		public this(int i, String n,String val, GonEntryType t)
		{
			index = i;
			name = n;
			type = t;
			valString = val;
		}
	}
	class gonSearch
	{
		private bool _succ;
		public bool Sucessfull
		{
			public get
			{
				return _succ;
			}
		}
		public String Error;
		public List<gonSearchResult> Items;

		///Private utility function to make the search object an error
		private gonSearch SetError(String param = "An error occured while searching")
		{
			_succ = false;
			Error = param;
			return this;
		}

	}	
}