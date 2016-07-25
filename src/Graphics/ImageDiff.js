"use strict";

var imageDiff = require("image-diff");

exports.diff_ = function (isJust) {
  return function (fromJust) {
    return function (options) {
      return function (cb, eb) {
        var opts = {
          actualImage: options.actual,
          expectedImage: options.expected,
          shadow: options.shadow
        };
        if (isJust(options.diff)) opts.diffImage = fromJust(options.diff);
        return imageDiff(opts, function (err, isSame) {
          return err ? eb(err) : cb(isSame);
        });
      };
    };
  };
};
