$ p w d   =   S p l i t - P a t h   - P a r e n t   $ M y I n v o c a t i o n . M y C o m m a n d . P a t h  
 .   " $ p w d \ C l e a n u p . p s 1 "  
 .   " $ p w d \ . . \ P e s t e r . p s 1 "  
  
 D e s c r i b e   " W h e n   i m p l e m e n t i n g   f i l e s y s t e m   t e s t s   i n   a   f i x t u r e "   {  
         S e t u p   - D i r   " f o o "  
 }  
  
 D e s c r i b e   " C l e a n u p "   {  
  
         I t   " s h o u l d   h a v e   r e m o v e d   t h e   t e m p   f o l d e r   f r o m   t h e   p r e v i o u s   f i x t u r e "   {    
                 - n o t   $ T e s t D r i v e . s h o u l d . e x i s t ( )  
         }  
  
         I t   " s h o u l d   a l s o   r e m o v e   t h e   T e s t D r i v e : "   {  
                 - n o t   " T e s t D r i v e : " . s h o u l d . e x i s t ( )  
         }  
 }  
 