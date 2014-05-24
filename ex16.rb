a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']
     

new_array = a.map {|word| word.split(' ')}

p new_array.flatten

     




