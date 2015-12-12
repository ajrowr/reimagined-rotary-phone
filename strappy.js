/* Used to be called btstrp.js before I started using Bootstrap a lot. So now I call it Strappy */
/* Just a handful of useful Javascript bits and pieces. The string formatting thing is more or less */
/* based on python string.format */

/* Check if obj is an instance of type */
function is(type, obj) {
    var clas = Object.prototype.toString.call(obj).slice(8, -1);
    return obj !== undefined && obj !== null && clas === type;
}

/* Add .format to String prototype */
if (!String.prototype.format) {
    String.prototype.format = function() {
        var args = arguments;
        return this.replace(/{(\d+)}/g, function(match, number) { 
            return typeof args[number] != 'undefined'
            ? args[number]
            : match
            ;
        });
    };
}

/* Add .dformat (dictionary format) to String prototype */
function __strdformat(fmt, repls) {
    return fmt.replace(/{(\w+)}/g, function (match, key) {
        return typeof repls[key] != 'undefined'
            ? repls[key]
            : match
    })
}
if (!String.prototype.dformat) String.prototype.dformat = function () {return __strdformat(this, arguments[0]);}

/* Add .aformat (annotated format) to String prototype */
function __straformat(fmt) {
    var args;
    if (is('Arguments', arguments[1])) {
        args = arguments[1];
    }
    else {
        args = Array.slice(arguments, 1);
    }
    return fmt.replace(/{(\d+)(\:\w*)?}/g, function (match, idx) {
        return typeof args[idx] != 'undefined'
            ? args[Number(idx)]
            : match
        ;
    });
}
if (!String.prototype.aformat) String.prototype.aformat = function () {return __straformat(this, arguments);}
