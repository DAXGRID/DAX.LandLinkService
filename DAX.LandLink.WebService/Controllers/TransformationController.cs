using DAX.IO;
using DAX.IO.Readers;
using DAX.LandLink.WebService.Config;
using Serilog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Web;
using System.Web.Http;

namespace DAX.LandLink.WebService.Controllers
{
    public class TransformationController : ApiController
    {
        static readonly ILogger Logger = Log.ForContext<TransformationController>();
        
        /// <summary>
        /// Process the posted data according to transformation specification. 
        /// If the writer (specificed in the transformation specification) is able to produce text or xml (i.e. geojson) that will be returned.
        /// If the writer (specificed in the transformation specification) is not able to produce output that can be returend (i.e. SQL writer), a http ok with no content will be return on successful completion.
        /// </summary>
        /// <returns></returns>
        public HttpResponseMessage Post(string specificationName, string projectName = null, string jobName = null, string userName = null)
        {
            Logger.Information("Incoming transformation command. TransformationSpecification='" + specificationName + "' JobName='" + jobName + "' ProjectName='" + projectName + "' UserName='" + userName + "'");

            try
            {
                var httpRequest = HttpContext.Current.Request;

                System.IO.StreamReader reader = new System.IO.StreamReader(httpRequest.InputStream);
                string inputData = reader.ReadToEnd();

                string landLinkConfig = AppSettings.Get("LandLinkConfigFile");

                var config = new TransformationConfig().LoadFromFile(landLinkConfig);

                var transformer = config.InitializeDataTransformer(specificationName);

                if (transformer.GetSpecification().Type != null && transformer.GetSpecification().Type.ToLower() == "import" && jobName == null)
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, "jobName parameter must be set on import transformations", new JsonMediaTypeFormatter());
                }

                var daxReader = transformer.GetFirstDataReader();

                transformer.GetFirstDataReader().Open(inputData);

                transformer.TransferData(projectName, jobName, userName);

                var writer = transformer.GetFirstDataWriter();
                var transformationResult = writer.GetResult();

                if (transformationResult != null)
                {
                    HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.NotModified);
                    resp.Content = new StringContent(transformationResult);
                    //resp.Content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");

                    return resp;
                }
                else
                {
                    return new HttpResponseMessage(HttpStatusCode.OK);
                }
            }
            catch (Exception ex)
            {
                return HttpErrorHelper.CreateHttpResponsForUnexpectedException(this, Logger, ex);
            }
        }
    }
}
