# encoding: utf-8
require 'spec_helper'

describe 'dashboard/index' do
  include ApplicationRspecHelpers

  describe 'authentication nav' do
    context 'when authenticated' do
      it 'should have Log Out' do
        stub_user
        render
        rendered.should have_selector('nav a', text: 'Đăng xuất')
      end
    end
  end
end