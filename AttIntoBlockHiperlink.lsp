(vl-load-com)

(princ (strcat "
	                Author - Robert Stokłosa
					Available commands:
					AttIntoBlockHiperlink - inserts a hyperlink into blocks with a name provided by the user. 
                    The hyperlink is retrieved from an attribute located within the block and specified by the user.
") )

(defun LM:vl-getattributevalue ( blk tag )
    (setq tag (strcase tag))
    (vl-some '(lambda ( att ) (if (= tag (strcase (vla-get-tagstring att))) (vla-get-textstring att))) (vlax-invoke blk 'getattributes))
)

(defun C:AttIntoBlockHiperlink (/ blockName przepiszVal ss i ent obj val)

	(setq blockName (getstring t "\nEnter the name of the block: "))
	(setq attName (getstring t "\nEnter the attribute of the block: "))
	(setq ss (ssget "_X" (list (cons 2 blockName))))
	(setq i 0)
	
	(repeat (sslength ss)
			(setq 	ent (ssname ss i))
			(setq	obj (vlax-ename->vla-object ent))
			(setq val (LM:vl-getattributevalue obj attName))
			(vla-add (vla-get-hyperlinks obj) val (vl-filename-base val))
			(setq i (+ i 1))
	)	
	
	(princ)
)