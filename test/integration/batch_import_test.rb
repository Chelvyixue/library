# coding: utf-8
require 'test_helper'

class BatchImportTest < ActionDispatch::IntegrationTest

  test "batch import test" do
    info = "9787100000505$苏鲁支语录$哲学$商务印书馆$[德]尼采 著 徐梵澄 译$2010$27.0$100\n9787532751464$都柏林人$文学$上海译文出版社$[爱尔兰]詹姆斯·乔伊斯 著 王逢振 译$2010$26.0$10\n9787562115915$五灯会元$文学$西南师范大学出版社$(宋)释普济$2005$68.0$1\n40000$五灯会元$文学$西南师范大学出版社$(宋)释普济$error_year$68.0$1"
    assert_difference "Book.count", 4 do
      post import_mul_path, book_list: info
    end
    assert_not Book.find_by(isbn: 40000)
    assert_equal Book.find_by(isbn: 9787100000505).title "苏鲁支语录"
  end
end
