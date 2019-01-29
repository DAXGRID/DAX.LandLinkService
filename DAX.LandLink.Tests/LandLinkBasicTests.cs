using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using DAX.IO;
using DAX.LandLink.WebService.Controllers;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace DAX.LandLink.Tests
{
    [TestClass]
    public class LandLinkBasicTests
    {
        string _testDataPath = "../../../TestData/";
        string _testConfigFile = "../../../TestData/Config/LandLinkConfig.xml";

        [TestMethod]
        public void TestLandXmlTransformation()
        {
            var httpClient = new HttpClient();
            var url = "http://localhost:53518/api";

            // Upload Fiber1.xml
            string uploadFileContent = File.ReadAllText(_testDataPath + "LeicaLandXML/Fiber1.xml");

            var request = new HttpRequestMessage(HttpMethod.Post, url + "/transformation?specificationName=LandXmlImport&projectName=test&jobName=test&userName=grummehans");
            request.Content = new StringContent(uploadFileContent, Encoding.UTF8, "text/xml");
            var response = httpClient.SendAsync(request).Result;
            var result = response.Content.ReadAsStringAsync().Result;

            Assert.IsTrue(result.Contains("ManufacturerType"));
            Assert.IsTrue(result.Contains("Flatliner(6xØ14)"));
        }

        [TestMethod]
        public void TestDsflTransformation()
        {
            var geoJsonFilename = _testDataPath + "/GeoJson/TestData.geojson";

            var url = "http://localhost:53518/api/transformation";

            var httpClient = new HttpClient();

            string uploadFileContent = File.ReadAllText(geoJsonFilename);

            var request = new HttpRequestMessage(HttpMethod.Post, url + "?specificationName=TelenetExport");
            request.Content = new StringContent(uploadFileContent, Encoding.UTF8, "text/xml");
            var response = httpClient.SendAsync(request).Result;

            var result = response.Content.ReadAsStringAsync().Result;

            // Check that we get some dsfl stuff back
            Assert.IsTrue(result.Contains("%kf7 %u13"));

        }

        [TestMethod]
        public void TestFiberTransformation()
        {
            var geoJsonFilename = _testDataPath + "/GeoJson/TestData.geojson";

            var url = "http://localhost:53518/api/transformation";

            var httpClient = new HttpClient();

            string uploadFileContent = File.ReadAllText(geoJsonFilename);

            var request = new HttpRequestMessage(HttpMethod.Post, url + "?specificationName=FiberTransfer");
            request.Content = new StringContent(uploadFileContent, Encoding.UTF8, "text/xml");
            var response = httpClient.SendAsync(request).Result;

            var result = response.Content.ReadAsStringAsync().Result;
        }


        [TestMethod]
        public void KlavsJsonTest()
        {
            var geoJsonFilename = _testDataPath + "/GeoJson/Klavs.geojson";

            var url = "http://localhost:53518/api/transformation";

            var httpClient = new HttpClient();

            string uploadFileContent = File.ReadAllText(geoJsonFilename);

            var request = new HttpRequestMessage(HttpMethod.Post, url + "?specificationName=LeicaLandXmlExport");

            //var request = new HttpRequestMessage(HttpMethod.Post, url + "?specificationName=TelenetExport");

            request.Content = new StringContent(uploadFileContent, Encoding.UTF8, "text/xml");
            var response = httpClient.SendAsync(request).Result;

            var result = response.Content.ReadAsStringAsync().Result;


        }
    }
}
