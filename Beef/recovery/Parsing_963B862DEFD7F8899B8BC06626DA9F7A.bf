using System;
namespace Gon
{
	class Parsing
	{
		public static Result<double> Parse_Double(StringView v)
		{
			String s = scope String(v);
			if(s.Count('.') > 1)
				return .Err;
			L:for(char8 c in v)
			{
				if(c.IsDigit || c == '.')
					continue L;
				else
					return .Err;
			}

			return double.Parse(s);
		}
	}
}