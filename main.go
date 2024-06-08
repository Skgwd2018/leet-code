package main

import (
	"fmt"
	"slices"
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
	fmt.Println("can_place_flowers:", canPlaceFlowers(flowerbed, n)) // false

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
