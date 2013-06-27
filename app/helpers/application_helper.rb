module ApplicationHelper
	 def content_for_or_pjax(name, &block)
		request.headers['X-PJAX'] ? yield : content_for(name, &Proc.new)
	end
end
