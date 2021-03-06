module matrix.api.filter;

import std.json;

import matrix;

immutable string EndpointType = "user/%s/filter";

struct Filter(Kind K)
  if (K == Kind.Request)
{
  auto urlParams()
  {
    return STATE.userId;
  }

  string data()
  {
    return "";
  }

  mixin RequestParameters!(EndpointType, HttpMethod.POST);
}

struct Filter(Kind K)
  if (K == Kind.Response)
{
  void parse(const ref JSONValue data)
  {
  }

  mixin ResponseParameters;
}
