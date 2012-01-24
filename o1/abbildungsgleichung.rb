#!/usr/bin/env ruby

state=0
num=""
type=""
g=0
b=0
sum=0.0
usum=0.0
count=0
ug=0.25
ub=0.25
ARGF.each do |line|
  if /^Linse/.match(line) then
      printf "avg=%.3f\n", sum/count
	  printf "avg(u)=%.3f\n", usum/count
      puts line
      sum = 0.0
	  usum = 0.0
      count = 0
  end
  num_md=/[gb]=([0-9.]*)/.match(line)
  num=num_md[1] if num_md
  type_md=/([gb])=/.match(line)
  type=type_md[1] if type_md
  if (type == "g") then
      g=num.to_f
  elsif (type == "b") then
      b=num.to_f
      f=1/(1/g+1/(b-g))
	  u=Math.sqrt(((1/(b-g)**2-1/g**2)/(1/g+1/(b-g))**2*ug)**2+(1/((1/g+1/(b-g))**2*(b-g)**2)*ub)**2)
      sum+=f
	  usum+=u
      count += 1
      printf "g=%.1f b=%.1f f=%.3f\n", g, b, f
      num=""
      type=""
      g=0
      b=0
  end
end
