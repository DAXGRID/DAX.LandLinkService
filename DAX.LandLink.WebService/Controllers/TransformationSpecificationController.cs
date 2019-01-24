using DAX.IO;
using DAX.LandLink.WebService.Config;
using Serilog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Web;
using System.Web.Http;

namespace DAX.LandLink.WebService.Controllers
{
    public class TransformationSpecificationController : ApiController
    {
        static readonly ILogger Logger = Log.ForContext<TransformationSpecificationController>();

        /// <summary>
        /// Retrieve list of all transformation specifications configured.
        /// </summary>
        /// <returns></returns>
        public HttpResponseMessage Get()
        {
            Logger.Information("Incoming transformation specification list request.");

            try
            {
                string landLinkConfig = AppSettings.Get("LandLinkConfigFile");

                var config = new TransformationConfig().LoadFromFile(landLinkConfig);


                List<object> resultList = new List<object>();


                foreach (var spec in config.TransformationSpecifications)
                {
                    var record = new
                    {
                        Name = spec.Name,
                        Description = spec.Description,
                        Type = spec.Type
                    };

                    resultList.Add(record);
                }


                return Request.CreateResponse(HttpStatusCode.Created, resultList, new JsonMediaTypeFormatter());
            }
            catch (Exception ex)
            {
                return HttpErrorHelper.CreateHttpResponsForUnexpectedException(this, Logger, ex);
            }
        }

    }
}
