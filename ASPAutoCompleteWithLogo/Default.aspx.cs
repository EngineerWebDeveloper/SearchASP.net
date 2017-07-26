using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASPAutoCompleteWithLogo
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<CountryMaster> GetCompanyName(string pre)
        {
            List<CountryMaster> allCountry = new List<CountryMaster>();
            using (MyDatabaseEntities dc = new MyDatabaseEntities())
            {
                allCountry = dc.CountryMasters.Where(a => a.CountryName.StartsWith(pre)).OrderBy(a => a.CountryName).ToList();
            }
            return allCountry;
        }
    }
}
