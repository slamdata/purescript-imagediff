// module Graphics.ImageDiff

var imageDiff = require("image-diff");

exports.diff_ = function(option, Nothing, Just) {
    return function(cb, eb) {
        var opts = {};
        if (option.diff.constructor == Just(undefined).constructor) {
            opts.diffImage = option.diff.value0;
        }
        opts.actualImage = option.actual;
        opts.expectedImage = option.expected;
        opts.shadow = option.shadow;
        return imageDiff(opts, function(err, isSame) {
            if (err) {
                return eb(err);
            }
            return cb(isSame);
        });
    };
};
