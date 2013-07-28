ActiveAdmin.register LopMonHoc do
  xlsx(:header_style => {:bg_color => 'FF0000', :fg_color => 'FF' }) do

    # deleting columns from the report
    delete_columns :id, :created_at, :updated_at

    # adding a column to the report
    column(:teacher_name) { |resource| "#{resource.giang_vien.ho_ten}" }

    # creating a chart and inserting additional data with after_filter
    after_filter { |sheet|
      sheet.add_row []
      sheet.add_row ['Teacher Name', 'Number of Classes']
      data = []
      labels = []
      GiangVien.all.each do |user|
        data << user.lop_mon_hocs.size
        labels << "#{user.ho_ten}"
        sheet.add_row [labels.last, data.last]
      end
      chart_color =  %w(88F700 279CAC B2A200 FD66A3 F20062 C8BA2B 67E6F8 DFFDB9 FFE800 B6F0F8)
      sheet.add_chart(::Axlsx::Pie3DChart, :title => "post by author") do |chart|
        chart.add_series :data => data, :labels => labels, :colors => chart_color
        chart.start_at 4, 0
        chart.end_at 7, 20
      end
    }

    # iserting data with before_filter
    before_filter do |sheet|
      sheet.add_row ['Created', Time.zone.now]
      sheet.add_row []
    end
  end
end
