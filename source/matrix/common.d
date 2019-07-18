module matrix.common;

immutable string[string] NULL_PARAMS;

string makeParamString(const string[string] params, string concat)
{
  import std.format : format;

  string result = concat;

  foreach (k, v; params) {
    result ~= "%s=%s&".format(k, v);
  }

  return result[0 .. $-1];
}

string buildUrl(
    string baseUrl,
    string endpoint,
    string accessToken = "",
    const string[string] params = NULL_PARAMS,
    string apiVersion = "r0",
    string apiSection = "client"
) {
  import std.algorithm : endsWith;
  import std.format : format;

  string concatChar = "?";
  string slash = "/";

  if (baseUrl.endsWith("/")) {
    slash = "";
  }

  string url = "%s%s_matrix/%s/%s/%s".format(
    baseUrl, slash, apiSection, apiVersion, endpoint
  );

  if (accessToken.length != 0) {
    concatChar = "&";
    url ~= "%saccess_token=%s".format("?", accessToken);
  }

  if (params.length != 0) {
    url ~= makeParamString(params, concatChar);
  }

  return url;
}