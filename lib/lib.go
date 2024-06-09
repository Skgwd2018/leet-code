package lib

type RecentCounter []int

func Constructor() (_ RecentCounter) {
	return
}

func (rc *RecentCounter) Ping(t int) int {
	*rc = append(*rc, t)
	for (*rc)[0] < t-3000 {
		*rc = (*rc)[1:]
	}

	return len(*rc)
}

//------------------------------------------------------

type ListNode struct {
	Val  int
	Next *ListNode
}

// ReverseList 反转链表
func ReverseList(head *ListNode) *ListNode {
	var prev, curr *ListNode = nil, head
	for curr != nil {
		next := curr.Next
		curr.Next = prev
		prev = curr
		curr = next
	}

	return prev
}

//------------------------------------------------------

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

// MaxDepth 二叉树的最大深度
func MaxDepth(root *TreeNode) int {
	if root == nil {
		return 0
	}

	lDepth := MaxDepth(root.Left)
	rDepth := MaxDepth(root.Right)

	return max(lDepth, rDepth) + 1
}

func dfs(node *TreeNode, nums *[]int) {
	if node == nil {
		return
	}

	dfs(node.Left, nums)
	if node.Left == nil && node.Right == nil {
		*nums = append(*nums, node.Val)
		return
	}
	dfs(node.Right, nums)
}

// LeafSimilar 叶子相似的树,中序遍历
func LeafSimilar(root1 *TreeNode, root2 *TreeNode) bool {
	nums1 := make([]int, 0)
	nums2 := make([]int, 0)
	dfs(root1, &nums1)
	dfs(root2, &nums2)
	if len(nums1) != len(nums2) {
		return false
	}
	for i := 0; i < len(nums1); i++ {
		if nums1[i] != nums2[i] {
			return false
		}
	}

	return true
}

// SearchBST 二叉搜索树,迭代操作
func SearchBST(root *TreeNode, val int) *TreeNode {
	for root != nil {
		if val == root.Val {
			return root
		}

		if val < root.Val {
			root = root.Left
		} else {
			root = root.Right
		}
	}

	return nil
}

//------------------------------------------------------
