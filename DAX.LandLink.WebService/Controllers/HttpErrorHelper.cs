using Serilog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.Http;

namespace DAX.LandLink.WebService.Controllers
{
    public static class HttpErrorHelper
    {
        /// <summary>
        /// Creates a internal server error response to an unexpected exception
        /// </summary>
        /// <param name="controller"></param>
        /// <param name="logger"></param>
        /// <param name="ex"></param>
        /// <returns></returns>
        public static HttpResponseMessage CreateHttpResponsForUnexpectedException(ApiController controller, ILogger logger, Exception ex)
        {
            string errorText = "LANDLINK SERVICE ERROR\r\nDer skete en uventet fejl i DAX LandLink webservicen.\r\nFejlen er gemt i en logfil på serveren.\r\n\r\n" + ex.ToString();
            logger.Error(ex, errorText);
            //return controller.Request.CreateResponse(HttpStatusCode.InternalServerError, errorText, );

            HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.InternalServerError);
            resp.Content = new StringContent(errorText);
            resp.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
            return resp;
        }
    }
}