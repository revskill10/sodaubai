class Enrollment extends Backbone.Model
  urlRoot: ->
    url = "lop_mon_hocs/#{@lop_mon_hoc_id}/lop_mon_hoc_sinh_viens" if @lop_mon_hoc_id != undefined
    url += "/#{@id}" if @id != undefined
    url