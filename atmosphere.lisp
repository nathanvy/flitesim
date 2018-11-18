;; flitesim uses the 1975 International Standard Atmosphere (ISA)
;; this current version cannot handle geopotential altitudes above 11000 metres

(defpackage :fs-atmosphere
  (:use
   :common-lisp))
(in-package fs-atmosphere)

(defconstant lapse-rate -0.0065 "lapse rate of the troposphere in degrees C per m")
(defconstant standard-gravity 9.80665 "standard gravity at earth's surface")
(defconstant base-density 1.2250 "kg/m^3")
(defconstant base-pressure 101325 "Pascals")
(defconstant base-temperature 288.15 "Kelvin")
(defconstant R-air 287.05287 "specific gas constant for air, in J/kg K")

;; temperature at 0 m MSL is +15.0 degrees
(defun temperature (h)
  (+ base-temperature (* lapse-rate h)))

;; pressure at MSL is 101.325 kPa
(defun static-pressure (h)
  (expt
   (/ (temperature h) base-temperature)
   (/ (* -1 standard-gravity)
      (* lapse-rate R-air))))

;; density at MSL is 1.2250 kg/m^3
(defun density-air (h)
  (expt
   (/ (temperature h) base-temperature)
   (* -1 (+ 1 (/ standard-gravity
		 (* lapse-rate R-air))))))
