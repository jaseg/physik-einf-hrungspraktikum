#!/usr/bin/env ruby

state=0
num=""
type=""
l=0
x1=0
x2=0
e=0
sum=0.0
count=0
ARGF.each do |line|
  if /^(Linse)|(System)/.match(line) then
      printf "avg=%.3f\n", sum/count
      puts line
      sum = 0.0
      count = 0
  end
  num_md=/[lx][12]?=([0-9.]*)/.match(line)
  num=num_md[1] if num_md
  type_md=/([lx][12]?)=/.match(line)
  type=type_md[1] if type_md
  if (type == "l") then
      l=num.to_f
  elsif (type == "x2") then
      x2=num.to_f
  elsif (type == "x1") then
      x1=num.to_f
      e=x2-x1
      f=(l**2-e**2)/(4*l)
      sum+=f
      count += 1
      printf "l=%.1f e=%.1f f=%.3f\n", l, e, f
      num=""
      type=""
  end
end
printf "avg=%.3f\n", sum/count
