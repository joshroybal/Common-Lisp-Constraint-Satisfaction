(load "csp.fas")
(setf *bay* '(1 2 3 4 5 6))
(setf *dst* '(chawston femswell ingleham maiseleigh neckerton olverdale))
(setf *via* '(dukeswood eckersham longvale mursfield pump-cross troughby))
(setf *rte* '(18 23 36 47 50 61))
(setf *domains* (cartesian-product *bay* *dst* *via* *rte*))
;; 1.
(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'maiseleigh x))
			  #'(lambda (x) (not (member 'pump-cross x)))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'maiseleigh x))
			  #'(lambda (x) (evenp (fourth x)))))

;; 2.
(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'olverdale x))
			  #'(lambda (x) (and
					 (not (member 'eckersham x))
					 (not (member 1 x))))))
(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 4 x))
			  #'(lambda (x) (member 'olverdale x))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'olverdale x))
			  #'(lambda (x) (and (not (member 18 x))
					     (not (member 61 x))))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'eckersham x))
			  #'(lambda (x) (not (member 61 x)))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 1 x))
			  #'(lambda (x) (not (member 18 x)))))

;; 3.
(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'femswell x))
			  #'(lambda (x) (not (member 'troughby x)))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'femswell x))
			  #'(lambda (x) (and (not (member 1 x))
					     (not (member 4 x))))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'troughby x))
			  #'(lambda (x) (and (not (member 3 x))
					     (not (member 6 x))))))

;; 4.
(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 'neckerton x))
			  #'(lambda (x) (member 'longvale x))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'neckerton x))
			  #'(lambda (x) (and (not (member 36 x))
					     (not (member 3 x))
					     (not (member 6 x))))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 36 x))
			  #'(lambda (x) (and (not (member 1 x))
					     (not (member 4 x))))))

;; 5.
(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 'dukeswood x))
			  #'(lambda (x) (member 2 x))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 2 x))
			  #'(lambda (x) (not (member 61 x)))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 5 x))
			  #'(lambda (x) (not (member 18 x)))))

;; 6.
(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 6 x))
			  #'(lambda (x) (member 47 x))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 6 x))
			  #'(lambda (x) (not (member 'chawston x)))))

;; 7.
(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 50 x))
			  #'(lambda (x) (not (member 'mursfield x)))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 50 x))
			  #'(lambda (x) (not (member 1 x)))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'mursfield x))
			  #'(lambda (x) (and (not (member 6 x))))))

;; constraints
(defun level-bays-p (bay1 bay2) (= (abs (- bay1 bay2))) 3)

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'pump-cross x))
			  #'(lambda (x) (and (not (member 4 x))
					     (not (member 3 x))
					     (not (member 1 x))))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'maiseleigh x))
			  #'(lambda (x) (and (not (member 5 x))
					     (not (member 6 x))
					     (not (member 1 x))))))

(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 'eckersham x))
			  #'(lambda (x) (member 47 x))))

(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 1 x))
			  #'(lambda (x) (member 61 x))))

(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 'olverdale x))
			  #'(lambda (x) (member 50 x))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'femswell x))
			  #'(lambda (x) (not (member 3 x)))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'mursfield x))
			  #'(lambda (x) (< (first x) 4))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 2 x))
			  #'(lambda (x) (< (fourth x) 36))))

(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 'neckerton x))
			  #'(lambda (x) (member 1 x))))

(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 36 x))
			  #'(lambda (x) (member 3 x))))

(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 'maiseleigh x))
			  #'(lambda (x) (member 2 x))))

(print-table (backtracking-search *domains* #'all-different-p 6))
