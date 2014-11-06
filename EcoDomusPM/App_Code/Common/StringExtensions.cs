using System;
using System.Collections.Generic;

public static class ExtensionMethods
{
    public static string Replace(this string s, List<char> separatorsList, string newVal)
    {
        var temp = s.Split(separatorsList.ToArray(), StringSplitOptions.RemoveEmptyEntries);
        return String.Join(newVal, temp);
    }
}