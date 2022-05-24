using System;
namespace gon_Utils
{
	class gonEntry
	{
		private bool _toggle;
		private double _number;
 		private String _string;
		private Gon _object;
		private GonEntryType _myType;

		
		public this(GonEntryType t, bool? togle = null,double? nmbr = null,String text = null, Gon g = null)
		{
		
		}

#region acessors
		public GonEntryType Type { public get => _myType; }
		[Warn("Errors if Type property doesn't match")]
		public bool Toggle
		{
			public get
			{
				if(_myType == .Toggle)
					return _toggle;
				Runtime.FatalError();
			}
		}
		[Warn("Errors if Type property doesn't match")]
		public double Number
		{
			public get
			{
				if(_myType == .Number)
					return _number;
				Runtime.FatalError();
			}
		}
		[Warn("Errors if Type property doesn't match")]
		public String Line
		{
			public get
			{
				if(_myType == .String)
					return _string;
				Runtime.FatalError();
			}
		}
		[Warn("Errors if Type property doesn't match")]
		public String Text
		{
			public get
			{
				if(_myType == .Text)
					return _string;
				Runtime.FatalError();
			}
		}
		[Warn("Errors if Type property doesn't match")]
		public String Data
		{
			public get
			{
				if(_myType == .Data)
					return _string;
				Runtime.FatalError();
			}
		}
		[Warn("Errors if Type property doesn't match")]
		public String Custom
		{
			public get
			{
				if(_myType == .Custom)
					return _string;
				Runtime.FatalError();
			}
		}
		[Warn("Errors if Type property doesn't match")]
		public Gon Object
		{
			public get
			{
				if(_myType == .Object)
					return _object;
				Runtime.FatalError();
			}
		}
#endregion
	}
}
