(require "csp" "csp.lisp")

(defvar *player* '(bob deke foxy kuby quaq))
(defvar *pos* '(center point-guard power-forward shooting-guard small-forward))
(defvar *show* '(dr-bunyan east-room everybody o.r. that-90s-show))
(defvar *time* '("8:00 p.m." "8:30 p.m." "9:00 p.m." "9:30 p.m." "10:00 p.m."))
(defvar *domains* (csp:cartesian-product *player* *pos* *show* *time*))

;;; 1. Quaq isn't the player who will appear on That 90's Show. Kuby (who isn't
;;; the power forward) will appear on the 8:00 p.m. show.
(setf *domains*
      (csp:filter-implication *domains*
			      #'(lambda (x) (member 'quaq x))
			      #'(lambda (x) (not (member 'that-90s-show x)))))

(setf *domains*
      (csp:filter-implication *domains*
			      #'(lambda (x) (member 'kuby x))
			      #'(lambda (x) (not (member 'power-forward x)))))

(setf *domains*
      (csp:filter-equivalence *domains*
			      #'(lambda (x) (member 'kuby x))
			      #'(lambda (x) (member "8:00 p.m." x
						    :test #'equalp))))

;;; 2. Bob (who is the point guard) and Quaq will be seen at 9:30 p.m. and
;;; 10:00 p.m., in some order. The power forward will appear on Everybody Loves
;;; Damon.
(setf *domains*
      (csp:filter-equivalence *domains*
			      #'(lambda (x) (member 'bob x))
			      #'(lambda (x) (member 'point-guard x))))

(setf *domains*
      (csp:filter-equivalence *domains*
			      #'(lambda (x) (or
					     (member 'bob x)
					     (member 'quaq x)))
			      #'(lambda (x) (or
					     (member "9:30 p.m." x
						     :test #'equalp)
					     (member "10:00 p.m." x
						     :test #'equalp)))))

(setf *domains*
      (csp:filter-equivalence *domains*
			      #'(lambda (x) (member 'power-forward x))
			      #'(lambda (x) (member 'everybody x))))

;;; 3. The shooting guard will make a special appearance on O.R. The small
;;; forward will appear on the the shoe that airs at 9:30 p.m.
(setf *domains*
      (csp:filter-equivalence *domains*
			      #'(lambda (x) (member 'shooting-guard x))
			      #'(lambda (x) (member 'o.r. x))))

(setf *domains*
      (csp:filter-equivalence *domains*
			      #'(lambda (x) (member 'small-forward x))
			      #'(lambda (x) (member "9:30 p.m." x
						    :test #'equalp))))

;;; 4. Deke is not the player who will appear on East Room (which airs at
;;; 8:30 p.m.).
(setf *domains*
      (csp:filter-implication *domains*
			      #'(lambda (x) (member 'deke x))
			      #'(lambda (x) (not (member 'east-room x)))))

(setf *domains*
      (csp:filter-equivalence *domains*
			      #'(lambda (x) (member 'east-room x))
			      #'(lambda (x) (member "8:30 p.m." x
						    :test #'equalp))))

(defvar *solution* (csp:backtracking-search *domains* #'csp:all-different-p 5))

(csp:print-table *solution*)
