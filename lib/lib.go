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
