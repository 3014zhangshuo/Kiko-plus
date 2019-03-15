https://leetcode.com/problems/two-sum/

```ruby
def two_sum(nums, target)
  dict = {}
  nums.each_with_index do |n, i|
    if dict[target - n]
      return dict[target - n], i
    end
    dict[n] = i
  end
end
```


```ruby
def two_sum(nums, target)
  nums.each_with_index do |num, index|
    rest = target - num
    rest_index = nums[(index + 1)..-1].index(rest)
    return [index, rest_index + index + 1] if rest_index
  end
end
```
