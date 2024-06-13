package main

import (
	"fmt"
	"leet-code/lib"
	"math"
	"math/bits"
	"slices"
	"sort"
	"strings"
)

func main() {
	fmt.Println("------ 交替合并字符串(字符串,双指针) ------")
	word1, word2 := "abcde", "xyz"
	fmt.Println("mergeAlternately:", mergeAlternately(word1, word2)) // axbyczde

	fmt.Println("------ 字符串的最大公因子(字符串,数学) ------")
	str1, str2 := "ABABAB", "AB"
	fmt.Println("gcdOfStrings:", gcdOfStrings(str1, str2)) // AB

	fmt.Println("------ 拥有最多糖果的孩子(数组) ------")
	candies := []int{2, 3, 5, 1, 3}
	extraCandies := 3
	fmt.Println("kidsWithCandies:", kidsWithCandies(candies, extraCandies)) // [true, true, true, false, true]

	fmt.Println("------ 种花问题(数组,贪心) ------")
	// flowerbed := []int{1, 0, 0, 0, 0, 1}
	flowerbed := []int{1, 0, 0, 0, 1, 0, 0}
	// flowerbed := []int{0, 1, 0}
	n := 3
	fmt.Println("canPlaceFlowers:", canPlaceFlowers(flowerbed, n)) // false

	fmt.Println("------ 反转字符串中的元音字母(字符串,双指针) ------")
	s := "leetcode"
	// s := "hello"
	fmt.Println("reverseVowels:", reverseVowels(s)) // leotcede

	fmt.Println("------ 移动零(数组,双指针) ------")
	nums := []int{0, 1, 0, 3, 12}
	// nums := []int{4, 1, 5, 3, 12}
	moveZeroes(nums) // [1, 3, 12, 0, 0]

	fmt.Println("------ 判断子序列(字符串,双指针,动态规划) ------")
	s, t := "ace", "abcde"
	fmt.Printf("Is %s a sub of %s? %t \n", s, t, isSubsequence(s, t)) // true

	fmt.Println("------ 子数组最大平均数(数组,滑动窗口) ------")
	nums = []int{1, 12, -5, -6, 50, 3}
	fmt.Println("findMaxAverage:", findMaxAverage(nums, 4)) // 12.75

	fmt.Println("------ 找到最高海拔(数组,前缀和) ------")
	gain := []int{-5, 1, 5, 0, -7}
	// gain := []int{-4, -3, -2, -1, 4, 3, 2}
	fmt.Println("largestAltitude:", largestAltitude(gain)) // 1

	fmt.Println("------ 寻找数组的中心下标(数组,前缀和) ------")
	nums = []int{1, 7, 3, 6, 5, 6}
	fmt.Println("pivotIndex:", pivotIndex(nums)) // 3

	fmt.Println("------ 找出两数组的不同(数组,哈希表) ------")
	nums1 := []int{1, 2, 3, 3}
	nums2 := []int{1, 2, 1, 2, 4}
	fmt.Println("findDifference:", findDifference(nums1, nums2)) // [[3], [4]]

	fmt.Println("------ 独一无二的出现次数(数组,哈希表) ------")
	arr := []int{1, 2, 2, 1, 1, 3}
	fmt.Println("unique_occurrences:", uniqueOccurrences(arr)) // true

	fmt.Println("------ 最近的请求次数(头尾高效操作的队列,数据流) ------")
	recentCounter := lib.Constructor()
	ret1 := recentCounter.Ping(1)
	fmt.Println("ping:", ret1) // 1
	ret2 := recentCounter.Ping(100)
	fmt.Println("ping:", ret2) // 2
	ret3 := recentCounter.Ping(3001)
	fmt.Println("ping:", ret3) // 3
	ret4 := recentCounter.Ping(3002)
	fmt.Println("ping:", ret4) // 3

	fmt.Println("------ 反转链表(递归,链表) ------")
	fmt.Println("------ 二叉树的最大深度(递归) ------")
	fmt.Println("------ 叶子相似的树(二叉树,dfs) ------")
	fmt.Println("------ 二叉搜索树(BST)中的搜索(二叉搜索树,迭代) ------")

	fmt.Println("------ 猜数字大小(二分查找) ------")
	fmt.Println("guessNumber:", guessNumber(10)) // 7

	fmt.Println("------ 第N个泰波那契数(动态规划) ------")
	n = 25
	fmt.Printf("tribonacci(%d): %d \n", n, tribonacci(n)) // 1389537

	fmt.Println("------ 使用最小花费爬楼梯(数组,动态规划) ------")
	// let cost = vec![10, 15, 20]; // 15
	cost := []int{1, 100, 1, 1, 1, 100, 1, 1, 100, 1}                  // 6
	fmt.Println("minCostClimbingStairs:", minCostClimbingStairs(cost)) // 6

	fmt.Println("------ 比特位计数(位运算,动态规划) ------")
	n = 5
	fmt.Printf("countBits(%d): %d \n", n, countBits(n)) // [0, 1, 1, 2, 1, 2]

	fmt.Println("------ 只出现一次的数字(位运算,数组) ------")
	nums = []int{4, 1, 2, 1, 2}
	fmt.Println("singleNumber:", singleNumber(nums)) // 4

	fmt.Println("\n-------------up---------------\n")

	fmt.Println("------ 反转字符串中的单词(字符串,双指针) ------")
	s = "  a good   example "
	fmt.Println("reverse_words:", reverseWords(s)) // example good a

	fmt.Println("------ 压缩字符串(字符串,双指针) ------")
	chars := []byte{'a', 'a', 'b', 'b', 'c', 'c', 'c'}
	// chars := []byte{'a'}
	// chars := []byte{'a', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b'}
	fmt.Println("compress:", compress(chars)) // 6  ['a', '2', 'b', '2', 'c', '3']

	fmt.Println("------ 盛最多水的容器(数组,双指针,贪心) ------")
	height := []int{1, 8, 6, 2, 5, 4, 8, 3, 7}
	// height := []int{1, 1}
	fmt.Println("maxArea:", maxArea(height)) // 49

	fmt.Println("------ 从字符串中移除星号(栈,字符串) ------")
	s = "leet**cod*e" // lecoe
	// s = "erase*****" // ""
	fmt.Println("removeStars:", removeStars(s))

	fmt.Println("------ 字符串解码(栈,字符串) ------")
	s = "3[a12[c]]" // accccccccccccaccccccccccccacccccccccccc
	// s = "3[a]2[bc]" // aaabcbc
	fmt.Println("decodeString:", decodeString(s)) // accccccccccccaccccccccccccacccccccccccc

	fmt.Println("----- 数组中的第k个最大元素(数组,分治,快速选择) ------")
	nums = []int{3, 2, 1, 5, 6, 4}
	// nums = []int{3, 2, 3, 1, 2, 4, 5, 5, 6}
	fmt.Println("findKthLargest:", findKthLargest(nums, 2)) // 5

	fmt.Println("----- 爱吃香蕉的珂珂(数组,二分查找) ------")
	// 这里有 n 堆香蕉，第 i 堆中有 piles[i] 根香蕉。警卫已经离开了，将在 h 小时后回来。
	// 珂珂可以决定她吃香蕉的速度 k (单位:根/小时)。每个小时，她将会选择一堆香蕉，从中吃掉 k 根。
	// 如果这堆香蕉少于 k 根，她将吃掉这堆的所有香蕉，然后这一小时内不会再吃更多的香蕉。
	// 珂珂喜欢慢慢吃，但仍然想在警卫回来前吃掉所有的香蕉。
	// 返回她可以在 h 小时内吃掉所有香蕉的最小速度 k(k 为整数)。
	piles := []int{30, 11, 23, 4, 20}
	h := 6
	fmt.Println("minEatingSpeed:", minEatingSpeed(piles, h))

	fmt.Println("----- 递增的三元子序列(贪心算法) ------")
	// 判断数组nums中是否存在长度为 3 的递增子序列。
	// 如果存在这样的三元组下标 (i, j, k) 且满足 i < j < k,使得 nums[i] < nums[j] < nums[k],返回 true;否则,返回 false
	// 三元组 (3, 4, 5) 满足题意，因为 nums[3] == 0 < nums[4] == 4 < nums[5] == 6,返回true
	nums = []int{2, 1, 5, 0, 4, 6}
	fmt.Println("increasing_triplet:", increasingTriplet(nums)) // true

	fmt.Println("----- 452. 用最少数量的箭引爆气球(贪心,数组,排序) ------")
	// 有许多球形气球贴在一堵用 XY 平面表示的墙面上。
	// 墙面上的气球记录在整数数组 points ，其中points[i] = [Xstart, Xend] 表示水平直径在 Xstart 和 Xend之间的气球。你不知道气球的确切 y 坐标。
	// 一支弓箭可以沿着 x 轴从不同点 完全垂直 地射出。
	// 在坐标 x 处射出一支箭，若有一个气球的直径的开始和结束坐标为 Xstart，Xend，且满足 Xstart ≤ X ≤ Xend，则该气球会被 引爆 。
	// 可以射出的弓箭的数量 没有限制 。弓箭一旦被射出之后，可以无限地前进。
	// 数组 points ,返回引爆所有气球所必须射出的 最小 弓箭数。
	points := [][]int{{10, 16}, {2, 8}, {1, 6}, {7, 12}}
	fmt.Println("findMinArrowShots:", findMinArrowShots(points)) // 2
}

// 交替合并字符串
func mergeAlternately(word1 string, word2 string) string {
	len1, len2 := len(word1), len(word2)
	result := make([]byte, 0, len1+len2) // 预分配空间
	i, m := 0, min(len1, len2)
	for i < m {
		result = append(result, word1[i], word2[i])
		i++
	}

	if i < len1 {
		result = append(result, word1[i:]...)
	}
	if i < len2 {
		result = append(result, word2[i:]...)
	}

	return string(result)
}

// 欧几里得算法即辗转相除法，指用于计算两个非负整数a，b的最大公约数。计算公式gcd(a,b) = gcd(b, a mod b)。
// 两个整数的最大公约数等于其中较小的数和两数相除余数的最大公约数
func getGCD(a, b int) int {
	if b == 0 {
		return a
	} else {
		return getGCD(b, a%b)
	}
}

// 如果两个字符串交替相加后，值仍然相等，即str1 + str2 == str2 + str1时，就可以认为存在公因子字符串。
// 当一定存在公因子时，最大公因子字符的长度一定就是两个字符串长度的最大公因数。
// 公因子字符串也就是str1或str2的前缀下标。范围为:[0，最大公因数]
func gcdOfStrings(str1 string, str2 string) string {
	if str1+str2 != str2+str1 {
		return ""
	}

	return str1[0:getGCD(len(str1), len(str2))]
}

func kidsWithCandies(candies []int, extraCandies int) []bool {
	// slice中取最大值
	mc := slices.Max(candies) - extraCandies
	result := make([]bool, len(candies))
	for i, c := range candies {
		result[i] = c >= mc
	}

	return result
}

func canPlaceFlowers(flowerbed []int, n int) bool {
	fl := len(flowerbed)
	for i := 0; i < fl; i++ {
		// 检查头尾&相邻项的问题
		if flowerbed[i] == 0 && (i == 0 || flowerbed[i-1] == 0) && (i == fl-1 || flowerbed[i+1] == 0) {
			n--
			i++ // 肯定不能种花,跳过一个位置
		}
	}

	return n <= 0
}

// 是否是元音字母
func isVowel(s byte) bool {
	if s == 'a' || s == 'e' || s == 'i' || s == 'o' || s == 'u' || s == 'A' || s == 'E' || s == 'I' || s == 'O' || s == 'U' {
		return true
	}
	return false
}

func reverseVowels(s string) string {
	b := []byte(s)
	for i, j := 0, len(b)-1; i < j; {
		if !isVowel(b[i]) {
			i++
			continue
		}
		if !isVowel(b[j]) {
			j--
			continue
		}

		b[i], b[j] = b[j], b[i]
		i++
		j--
	}

	return string(b)
}

func moveZeroes(nums []int) {
	// 双指针操作
	for i, j := 0, 0; i < len(nums); i++ {
		if nums[i] != 0 {
			//nums[i], nums[j] = nums[j], nums[i]
			nums[j] = nums[i]
			if i != j {
				nums[i] = 0
			}

			j++
		}
	}

	fmt.Println(nums)
}

func isSubsequence(s string, t string) bool {
	//sb, tb := []byte(s), []byte(t) // 性能没区别
	sl, tl := len(s), len(t)
	si, ti := 0, 0
	for ti < tl {
		if si < sl && s[si] == t[ti] {
			si++
		}
		ti++
	}

	return si == sl
}

func findMaxAverage(nums []int, k int) float64 {
	if len(nums) == 1 {
		return float64(nums[0])
	}

	wSum := 0
	for _, v := range nums[:k] {
		wSum += v
	}
	maxSum := wSum
	for i := k; i < len(nums); i++ {
		wSum += nums[i] - nums[i-k]
		// 比较取最大值
		maxSum = max(maxSum, wSum)
	}

	return float64(maxSum) / float64(k)
}

func largestAltitude(gain []int) int {
	highest, cSum := 0, 0
	for _, g := range gain {
		cSum += g
		highest = max(highest, cSum)
	}

	return highest
}

func pivotIndex(nums []int) int {
	sum := 0
	for _, v := range nums {
		sum += v
	}

	for i, v := range nums {
		sum -= v
		if sum == 0 {
			return i
		}
		sum -= v
	}

	return -1
}

func findDifference(nums1 []int, nums2 []int) [][]int {
	//set1, set2 := map[int]bool{}, map[int]bool{}
	set1, set2 := make(map[int]bool, len(nums1)), make(map[int]bool, len(nums2))
	for _, v := range nums1 {
		set1[v] = true
	}
	for _, v := range nums2 {
		set2[v] = true
	}

	//var a1, a2 []int
	result := make([][]int, 2)
	for k := range set1 {
		if !set2[k] {
			result[0] = append(result[0], k)
		}
	}
	for k := range set2 {
		if !set1[k] {
			result[1] = append(result[1], k)
		}
	}

	//return [][]int{a1, a2}
	return result
}

func uniqueOccurrences(arr []int) bool {
	// 记录每个数的出现次数
	cntMap := make(map[int]int)
	for _, v := range arr {
		cntMap[v]++
	}

	// 验证是否有重复出现次数
	occMap := make(map[int]struct{})
	for _, v := range cntMap {
		if _, ok := occMap[v]; ok {
			return false
		}
		occMap[v] = struct{}{}
	}

	return true
}

func guess(num int) int {
	switch {
	case num < 7:
		return 1
	case num > 7:
		return -1
	default:
		return 0
	}
}
func guessNumber(n int) int {
	// 二分法
	for low := 1; low < n; {
		mid := low + (n-low)/2
		if guess(mid) == 1 {
			low = mid + 1
		} else {
			n = mid
		}
	}
	return n

	// 解法二:闭包操作
	/*result := 1 + sort.Search(n, func(i int) bool {
		return guess(i+1) != 1
	})
	return result*/
}

// 使用动态规划避免重复计算
// 泰波那契序列 Tn 定义如下：
// T0 = 0, T1 = 1, T2 = 1, 且在 n >= 0 的条件下 Tn+3 = Tn + Tn+1 + Tn+2
// 给你整数 n，请返回第 n 个泰波那契数 Tn 的值。
func tribonacci(n int) int {
	if n == 0 {
		return 0
	}
	if n <= 2 {
		return 1
	}

	p1, p2, p3 := 0, 1, 1
	for i := 2; i < n; i++ {
		p1, p2, p3 = p2, p3, p1+p2+p3
	}
	return p3
}

func minCostClimbingStairs(cost []int) int {
	c1, c2 := cost[0], cost[1]
	for i := 2; i < len(cost); i++ {
		c1, c2 = c2, min(c1, c2)+cost[i]
	}
	return min(c1, c2)

	// 解法二:
	/*dp := make([]int, len(cost)+1)
	for i := 2; i < len(dp); i++ {
		dp[i] = min(dp[i-1]+cost[i-1], dp[i-2]+cost[i-2])
	}
	return dp[len(cost)]*/
}

// 位运算
// 输入：n = 5
// 输出：[0,1,1,2,1,2]
// 解释：
// 0 --> 0
// 1 --> 1
// 2 --> 10
// 3 --> 11
// 4 --> 100
// 5 --> 101
func countBits(n int) []int {
	// 动态规划 + Brian Kernighan 算法
	/*dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		// 比特位计数:根据动态规划可以得知二进制数之间的转换关系。
		// 使用布赖恩·克尼根算法求出关系式:清除n的最右一位1的值即 clr_left_1bit = num&(num - 1)
		dp[i] = dp[i&(i-1)] + 1
	}
	return dp*/

	//解法二:使用内置函数
	result := make([]int, n+1)
	for i := 0; i <= n; i++ {
		result[i] = bits.OnesCount(uint(i))
	}
	return result
}

// 题目：给你一个 非空 整数数组 nums,除了某个元素只出现一次以外,其余每个元素均出现两次。找出那个只出现了一次的元素。
// 假设数组中重复的元素为x,只出现一次的元素为y。
// 将数组中的所有元素进行异或运算,由于x出现了两次,所以x和x异或的结果为0,而y只出现了一次,所以最后的结果就是y。
// 异或（XOR）运算问题。异或运算有一个重要的性质:任何数和0异或都等于它本身,任何数和其自身异或都等于0。
func singleNumber(nums []int) int {
	single := 0
	for _, v := range nums {
		single ^= v
	}
	return single
}

func reverseWords(s string) string {
	// 切割单个/多个空格,提取出单词slice
	words := strings.Fields(s)
	// 反转即对换位置
	for i := 0; i < len(words)/2; i++ {
		words[i], words[len(words)-1-i] = words[len(words)-1-i], words[i]
	}
	// 重新使用空格连接单词
	result := strings.Join(words, " ")
	return result
}

func compress(chars []byte) int {
	n := len(chars)
	if n <= 1 {
		return n
	}

	// 解法一:
	/*idx, count := 0, 1
	for i := 1; i < n; i++ {
		if chars[i-1] == chars[i] {
			count++
		} else {
			chars[idx] = chars[i-1]
			idx++
			if count > 1 {
				for _, c := range strconv.Itoa(count) {
					chars[idx] = byte(c)
					idx++
				}
			}
			count = 1
		}
	}

	chars[idx] = chars[n-1]
	idx++
	if count > 1 {
		for _, c := range strconv.Itoa(count) {
			chars[idx] = byte(c)
			idx++
		}
	}
	return idx*/

	// 解法二:
	write, left := 0, 0
	for read, ch := range chars {
		if read == n-1 || ch != chars[read+1] {
			chars[write] = ch
			write++
			num := read - left + 1
			if num > 1 {
				anchor := write
				for ; num > 0; num /= 10 {
					chars[write] = '0' + byte(num%10)
					write++
				}
				s := chars[anchor:write]
				for i, n := 0, len(s); i < n/2; i++ {
					s[i], s[n-1-i] = s[n-1-i], s[i]
				}
			}
			left = read + 1
		}
	}
	return write
}

func maxArea(height []int) int {
	left, right := 0, len(height)-1
	mArea, currArea := 0, 0
	for left < right {
		currArea = min(height[left], height[right]) * (right - left)
		mArea = max(mArea, currArea)
		if height[left] < height[right] {
			left++
		} else {
			right--
		}
	}

	return mArea
}

func removeStars(s string) string {
	/*var stack []byte
	for _, b := range []byte(s) {
		if b == '*' {
			stack = stack[:len(stack)-1]
		} else {
			stack = append(stack, b)
		}
	}
	return string(stack)*/

	// 解法二:
	stack := make([]byte, len(s))
	su := 0
	for i := 0; i < len(s); i++ {
		if s[i] != '*' {
			stack[su] = s[i]
			su++
		} else {
			su--
		}
	}
	return string(stack[:su])
}

func isNumber(u uint8) bool {
	return u >= '0' && u <= '9'
}

// 题目要求:原始数据不包含数字,所有的数字只表示重复的次数 k,例:不会出现像 3a 或 2[4] 的输入, s 中所有整数的取值范围为 [1, 300]
func decodeString(s string) string {
	currNum, numStack := 0, make([]int, 0)
	currStr, strStack := "", make([]string, 0)
	for i := 0; i < len(s); i++ {
		if isNumber(s[i]) {
			currNum = currNum*10 + int(s[i]-'0')
		} else if s[i] == '[' {
			numStack = append(numStack, currNum)
			strStack = append(strStack, currStr)
			currNum, currStr = 0, ""
		} else if s[i] == ']' {
			item := ""
			for j := 0; j < numStack[len(numStack)-1]; j++ {
				item += currStr
			}
			currStr = strStack[len(strStack)-1] + item

			numStack = numStack[:len(numStack)-1]
			strStack = strStack[:len(strStack)-1]
		} else {
			currStr += string(s[i])
		}
	}

	return currStr
}

// 快速选择
func quickSelect(nums []int, left, right, k int) int {
	if left == right {
		return nums[k]
	}

	partition := nums[left]
	i := left - 1
	j := right + 1
	for i < j {
		for i++; nums[i] < partition; i++ {
		}
		for j--; nums[j] > partition; j-- {
		}
		if i < j {
			nums[i], nums[j] = nums[j], nums[i]
		}
	}

	if k <= j {
		return quickSelect(nums, left, j, k)
	} else {
		return quickSelect(nums, j+1, right, k)
	}
}

func findKthLargest(nums []int, k int) int {
	n := len(nums)
	return quickSelect(nums, 0, n-1, n-k)
}

func minEatingSpeed(piles []int, h int) int {
	return 1 + sort.Search(slices.Max(piles)-1, func(mid int) bool {
		mid++
		sum := len(piles)
		for _, p := range piles {
			sum += (p - 1) / mid
		}
		return sum <= h
	})
}

func increasingTriplet(nums []int) bool {
	if len(nums) < 3 {
		return false
	}

	first, second := math.MaxInt32, math.MaxInt32
	for _, num := range nums {
		if num <= first {
			first = num
		} else if num <= second {
			second = num
		} else {
			return true
		}
	}

	return false
}

func findMinArrowShots(points [][]int) int {
	sort.Slice(points, func(i, j int) bool {
		return points[i][1] < points[j][1]
	})

	cnt := 1
	end := points[0][1]
	for _, p := range points {
		if p[0] > end {
			cnt++
			end = p[1]
		}
	}

	return cnt
}
