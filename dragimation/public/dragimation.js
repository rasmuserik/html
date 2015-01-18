// Generated by CoffeeScript 1.6.1
(function() {

  window.dragimation = function($elems, ypos, startDragFn, dragDoneFn) {
    var $dragged, handleTouchEnd, initialiseMovement, move, moving, x0, xscale, y0, yscale;
    moving = false;
    $elems.on("mousedown touchstart", function(event) {
      event.preventDefault();
      initialiseMovement(this);
      if (startDragFn != null) {
        startDragFn.call($dragged, event);
      }
      $("body").on("mousemove touchmove", move);
      $("body").on("mouseup mouseleave touchend", handleTouchEnd);
      return false;
    });
    handleTouchEnd = function(event) {
      if (!moving) {
        return;
      }
      moving = false;
      $("body").off("mousemove touchmove", move);
      $("body").off("mouseup mouseleave touchend", handleTouchEnd);
      $dragged.css("transform", "matrix(1,0,0,1,0,0)");
      $dragged.css("-webkit-transform", "matrix(1,0,0,1,0,0)");
      $dragged.css("-ms-transform", "matrix(1,0,0,1,0,0)");
      $dragged.css("-moz-transform", "matrix(1,0,0,1,0,0)");
      if (dragDoneFn != null) {
        dragDoneFn.call($dragged, event);
      }
      return false;
    };
    x0 = void 0;
    y0 = void 0;
    $dragged = void 0;
    xscale = void 0;
    yscale = void 0;
    initialiseMovement = function(dragged) {
      var pos;
      moving = true;
      $dragged = $(dragged);
      pos = $dragged.offset();
      x0 = pos.left;
      y0 = pos.top;
      xscale = $dragged.outerWidth();
      return yscale = $dragged.outerHeight() * ypos;
    };
    return move = function(e) {
      var transform, transformStr, x, y, _ref;
      if (!moving) {
        return;
      }
      window.e = e;
      e = ((_ref = e.originalEvent.touches) != null ? _ref[0] : void 0) || e;
      x = (e.pageX - x0) / xscale;
      y = (e.pageY - y0) / yscale;
      y = Math.max(y, 1);
      transform = [1, 0, xscale / yscale * (x - 0.5), y, 0, 0];
      transformStr = "matrix(" + transform + ")";
      return $dragged.css({
        "transform-origin": "top",
        "-webkit-transform-origin": "top",
        "-ms-transform-origin": "top",
        "-moz-transform-origin": "top",
        "transform": transformStr,
        "-webkit-transform": transformStr,
        "-ms-transform": transformStr,
        "-moz-transform": transformStr
      });
    };
  };

}).call(this);