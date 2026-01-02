(load "csp")
(defvar *day* '(monday tuesday wednesday thursday friday))
(defvar *location*  '(london oxford reading saffron-walden windsor))
(defvar *symptoms* '(back-pain chest-pains headache nausea stomach-pains))
(defvar *placebos* '(blue-medicine green-capsules pink-capsules purple-tablets
		     yellow-tablets))

(defvar *domains* nil)
(setf *domains* (cartesian-product *day* *location* *symptoms* *placebos*))

;;; sort of arc consistency stuff

;; 1.
(setf *domains* (filter (lambda (x) (equivalent (member 'chest-pains x)
						(member 'yellow-tablets x)))
			*domains*))

(setf *domains* (filter (lambda (x) (implies (member 'monday x)
					     (not (member 'chest-pains x))))
			*domains*))

(setf *domains* (filter (lambda (x) (equivalent (member 'blue-medicine x)
						(member 'oxford x)))
			*domains*))

(setf *domains* (filter (lambda (x) (implies (member 'friday x)
					     (not (member 'oxford x))))
			*domains*))

;; 2.
(setf *domains* (filter-equivalence *domains* #'(lambda (x) (member 'nausea x)) #'(lambda (x) (member 'saffron-walden x))))

(setf *domains* (filter-implication *domains* #'(lambda (x) (member 'nausea x)) #'(lambda (x) (not (member 'monday x)))))

(setf *domains* (filter-implication *domains* #'(lambda (x) (member 'purple-tables x)) #'(lambda (x) (not (member 'friday x)))))

;; 3.
(setf *domains* (filter-implication *domains* #'(lambda (x) (member 'friday x)) #'(lambda (x) (not (member 'reading x)))))

(setf *domains* (filter-equivalence *domains* #'(lambda (x) (member 'friday x)) #'(lambda (x) (member 'back-pain x))))

;;; 4.
(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 'thursday x))
			  #'(lambda (x) (member 'pink-capsules x))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'monday x))
			  #'(lambda (x) (not (member 'stomach-pains x)))))

;;; 5.
(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'london x))
			  #'(lambda (x) (not (member 'purple-tablets x)))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'headache x))
			  #'(lambda (x) (not (member 'blue-medicine x)))))

;;; 6.
(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 'wednesday x))
			  #'(lambda (x) (member 'windsor x))))

(print-table (backtracking-search *domains* #'all-different-p 5))
