using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace DAX.LandLink.WebService.Config
{
    public static class AppSettings
    {
        public static string Get(string key)
        {
            if (ConfigurationManager.AppSettings[key] == null)
                throw new KeyNotFoundException($"Could not find appsetting with key '{key}'");

            return ConfigurationManager.AppSettings[key];
        }

        public static string ConnectionString(string name)
        {
            return ConfigurationManager.ConnectionStrings[name]?.ConnectionString;
        }
    }
}