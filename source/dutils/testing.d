module dutils.testing;

import std.algorithm.comparison : equal;
import std.traits : isNumeric, isBoolean;

void assertEqual(T)(T actual, T expected) {
  bool equals = false;

  static if (isNumeric!T || isBoolean!T) {
    equals = actual == expected;
  } else {
    equals = equal(actual, expected);
  }

  if (!equals) {
    import std.conv : to;

    string actualString;
    string expectedString;
    try {
      actualString = actual.to!string;
      expectedString = expected.to!string;
    } catch (Exception exception) {
    }

    if (actualString != "" && expectedString != "") {
      throw new Exception("Expected " ~ actualString ~ " to equal " ~ expectedString);
    }

    throw new Exception("Output did not equal expected output");
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

unittest {
  assertEqual("testing", "testing");
}

unittest {
  bool failed = false;

  try {
    assertEqual("bad text", "testing");
    failed = true;
  } catch (Exception exception) {
    assert(exception.message == "Expected bad text to equal testing");
  }

  assert(failed == false);
}

unittest {
  assertEqual(123, 123);
}

unittest {
  bool failed = false;

  try {
    assertEqual(123, 1232);
    failed = true;
  } catch (Exception exception) {
    assert(exception.message == "Expected 123 to equal 1232");
  }

  assert(failed == false);
}

unittest {
  assertEqual([123, 1, 3, 4], [123, 1, 3, 4]);
}

unittest {
  bool failed = false;

  try {
    assertEqual([123, 1, 3], [123, 1, 3, 4]);
    failed = true;
  } catch (Exception exception) {
    assert(exception.message == "Expected [123, 1, 3] to equal [123, 1, 3, 4]");
  }

  assert(failed == false);
}
