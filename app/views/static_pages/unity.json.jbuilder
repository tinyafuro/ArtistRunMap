#json.extract! モデルオブジェクトの指定したカラム要素のキーと値のペアのハッシュを出力
json.array! @places do |place|
    json.extract! place, :id, :name, :address, :latitude, :longitude
end