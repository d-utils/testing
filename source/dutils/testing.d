module dutils.testing;

void assertEqual(T)(T actual, T expected) {
  if (actual != expected) {
    import std.conv : to;

    throw new Exception("Expected " ~ actual.to!string ~ " to equal " ~ expected.to!string);
  }
}

unittest {
  bool failed = false;

  try {
    assertEqual(true, false);
    failed = true;
  } catch (Exception exception) {
    assert(exception.message == "Expected true to equal false");
  }

  assert(failed == false);
}

unittest {
  int add(int a, int b) {
    return a + b;
  }

  assertEqual(add(12, 4), 16);
}
