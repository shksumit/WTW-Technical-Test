using System;
using System.IO;
using CsvHelper;
using System.Linq;

namespace FileRW
{
    class FileHandling
    {
        static void Main(String[] args)
        {
            using (StreamReader csv1 = new StreamReader(@"C:\WTW Files\File 1.csv"))
            using (StreamReader csv2 = new StreamReader(@"C:\WTW Files\File 2.csv"))                              
             
            {                
                var differences = new List<string>();
                int lineNum = 0;
                
                while (!csv1.EndOfStream)
                {
                    
                    var line1 = csv1.ReadLine();
                    
                    if (csv2.EndOfStream)
                    {
                        
                            var line2 = csv2.ReadLine();
                           
                            if (line1 != line2)
                            {
                                 differences.Add(string.Format("Line {0} differs. File 1: {1}, File 2: {2}", lineNum, line1, line2));
                                Console.WriteLine(differences);
                            }
                        
                    }
              

                }
        
            
            }
        }
    }
}