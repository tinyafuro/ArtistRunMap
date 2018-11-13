#json.extract! モデルオブジェクトの指定したカラム要素のキーと値のペアのハッシュを出力
json.places do
    json.array! @places do |place|
        json.extract! place, :id, :name, :address, :latitude, :longitude
    end
end
