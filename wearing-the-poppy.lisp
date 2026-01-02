(load "csp.lisp")
(defvar *pos* '(1 2 3 4))
(defvar *name* '(harry jack norman simon))
(defvar *age* '(82 83 84 85))
(defvar *service* '(RAF RAMC ROYAL-ENGINEERS ROYAL-NAVY))
(defvar *domains* nil)
(setf *domains* (cartesian-product *pos* *name* *age* *service*))

;;; 1. Simon is older than the immediately to his left.
(setf *domains* (filter-implication *domains*
				    #'(lambda (x) (member 'simon x))
				    #'(lambda (x) (and
						   (> (third x) 82)
						   (> (first x) 1)))))

;;; 2. The most junior of the four veterans, aged 82, is seated in position 4.
(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 82 x))
			  #'(lambda (x) (member 4 x))))

;;; 3. The wartime RAF bomber pilot is pictured next left from the man aged 84.
(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'RAF x))
			  #'(lambda (x) (and
					 (not (member 4 x))
					 (not (member 84 x))))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 84 x))
			  #'(lambda (x) (not (member 1 x)))))

;;; 4. Norman, who served in the Royal Engineers, is a year older than Jack, who
;;; is sitting next to him on the bench, and who did not serve in the Royal Army
;;; Medical Corps (RAMC).
(setf *domains*
      (filter-equivalence *domains*
			  #'(lambda (x) (member 'Norman x))
			  #'(lambda (x) (member 'Royal-Engineers x))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'Norman x))
			  #'(lambda (x) (not (member 82 x)))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'Jack x))
			  #'(lambda (x) (and
					 (not (member 85 x))
					 (not (member 'RAMC x))))))

;;; 4. The Royal Navy veteran is older than Harry.
(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'ROYAL-NAVY x))
			  #'(lambda (x) (and
					 (not (member 'Harry x))
					 (not (member 82 x))))))

(setf *domains*
      (filter-implication *domains*
			  #'(lambda (x) (member 'Harry x))
			  #'(lambda (x) (not (member 85 x)))))

(defun constraints-p (domains)
  (all-different-p domains))

