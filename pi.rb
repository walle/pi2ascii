#!/usr/bin/env ruby

continue = true
Signal.trap("SIGINT") do
  continue = false
end

buf = ''
res = ''

k, a, b, a1, b1 = 2, 4, 1, 12, 4
loop do
  break unless continue
  p, q, k = k*k, 2*k+1, k+1
  a, b, a1, b1 = a1, b1, p*a+q*a1, p*b+q*b1
  d, d1 = a/b, a1/b1
  while d == d1
    if buf.length == 3
      unless buf.start_with? '1'
        buf = ''
      else
        buf = buf[1..-1]
      end
    end
    buf += d.to_s
    val = buf.to_i
    if val == 32 || (val >= 65 && val <= 90) || (val >= 97 && val <= 122)
      print val.chr.downcase
      $stdout.flush
      res += val.chr.downcase
      buf = ''
    end
    a, a1 = 10*(a%b), 10*(a1%b1)
    d, d1 = a/b, a1/b1
  end
end

puts "\n\n"
puts 'Words:'
res.split(' ').each do |word|
  puts word if word.length < 13
end
