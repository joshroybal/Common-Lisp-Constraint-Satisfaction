(defpackage :csp
  (:use :cl)
  (:export #:filter-implication
	   #:filter-equivalence
	   #:enumerate-interval
	   #:cartesian-product
	   #:all-different-p
	   #:backtracking-search
	   #:print-table))

(in-package :csp)

(defun implies (p q) (or (not p) q))
(defun equivalent (p q) (and (implies p q) (implies q p)))
(defun filter (pred seq) (remove-if-not pred seq))

(defun filter-implication (seq p q)
  (filter #'(lambda (x) (implies (funcall p x) (funcall q x))) seq))

(defun filter-equivalence (seq p q)
  (filter #'(lambda (x) (equivalent (funcall p x) (funcall q x))) seq))

(defun enumerate-interval (lo hi)
  (do ((i hi (- i 1))
       (res nil (cons i res)))
      ((< i lo) res)))

(defun flatten (lis)
  (cond ((null lis) nil)
	((atom (car lis)) (cons (car lis) (flatten (cdr lis))))
	(t (nconc (flatten (car lis)) (flatten (cdr lis))))))

(defun pairs (x lis)
  (do ((seq lis (cdr seq))
       (res nil (cons (list x (car seq)) res)))
      ((null seq) (nreverse res))))

(defun product-2 (lis1 lis2) (mapcan #'(lambda (x) (pairs x lis2)) lis1))

(defun cartesian-product (&rest lists)
  (mapcar #'flatten (reduce #'product-2 lists)))

;;; keep as reserve functionality
(defun variables-domains (variables &rest domains)
  (let ((d (reduce #'cartesian-product domains)))
    (mapcar #'(lambda (x) (cons x d)) variables)))

(defun all-different-p (list-of-lists)
  (let ((lis (flatten list-of-lists)))
    (let ((seq (remove-duplicates lis)))
      (= (length lis) (length seq)))))

(defun backtracking-search (list-of-lists logical-p n)
  (labels ((backtrack (remaining curr)
             (cond ((= (length curr) n) (cond ((funcall logical-p curr) curr)))
		   ((null remaining) nil)
                   (t (or (backtrack (cdr remaining)
                                     (append curr (list (car remaining))))
                          (backtrack (cdr remaining) curr))))))
    (backtrack list-of-lists nil)))

(defun print-table (soln)
  (cond ((null soln) 'done)
	(t (progn
	     (format t "~&" (car soln))
	     (dolist (x (car soln)) (format t "~20A" x))
	     (print-table (cdr soln))))))
