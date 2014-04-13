(function($) {
  FlipClock.DailyCounterFace = FlipClock.Face.extend({
    showSeconds: true,

    constructor: function(factory, options) {
      this.base(factory, options);
    },

    build: function(excludeHours, time) {
      var t        = this;
      var children = this.factory.$wrapper.find('ul');
      var lists    = [];
      var offset   = 0;

      time     = time ? time : this.factory.time.getDayCounter(this.showSeconds);

      if(time.length > children.length) {
        $.each(time, function(i, digit) {
          lists.push(t.createList(digit));
        });
      }

      this.factory.lists = lists;

      if(this.showSeconds) {
        $(this.createDivider('Seconds')).insertBefore(this.factory.lists[this.factory.lists.length - 2].$obj);
      }
      else {
        offset = 2;
      }

      $(this.createDivider('Minutes')).insertBefore(this.factory.lists[this.factory.lists.length - 4 + offset].$obj);
      $(this.createDivider('Hours')).insertBefore(this.factory.lists[this.factory.lists.length - 6 + offset].$obj);
      $(this.createDivider('Days', true)).insertBefore(this.factory.lists[0].$obj);

      this._clearExcessDigits();

      if(this.autoStart) {
        this.start();
      }
    },

    flip: function(doNotAddPlayClass, time) {
      if(!time) {
        time = this.factory.time.getDayCounter(this.showSeconds);
      }
      this.base(time, doNotAddPlayClass);
    },

    _clearExcessDigits: function() {
      var tenSeconds = this.factory.lists[this.factory.lists.length - 2];
      var tenMinutes = this.factory.lists[this.factory.lists.length - 4];

      for(var x = 6; x < 10; x++) {
        tenSeconds.$obj.find('li:last-child').remove();
        tenMinutes.$obj.find('li:last-child').remove();
      }
    }
  });
}(jQuery));
