$ p w d   =   S p l i t - P a t h   - P a r e n t   $ M y I n v o c a t i o n . M y C o m m a n d . P a t h  
 .   " $ p w d \ S e t u p . p s 1 "  
 .   " $ p w d \ . . \ P e s t e r . p s 1 "  
  
 D e s c r i b e   " C o n t a i n s   a   h e l p e r   t o   o b t a i n   t e s t   d r i v e "   {  
         S e t u p  
  
         I t   " r e t u r n s   a   l o c a t i o n   t h a t   i s   i n   a   t e m p   a r e a "   {  
                 $ r e s u l t   =   $ T e s t D r i v e  
                 $ r e s u l t . s h o u l d . b e ( " $ e n v : T e m p \ p e s t e r " )  
         }  
  
         I t   " c r e a t e s   a   d r i v e   l o c a t i o n   c a l l e d   T e s t D r i v e : "   {  
                 " T e s t D r i v e : \ " . s h o u l d . e x i s t ( )  
         }  
 }  
  
 D e s c r i b e   " C r e a t e   f i l e s y s t e m   w i t h   d i r e c t o r i e s "   {  
          
         S e t u p   - D i r   " d i r 1 "  
         S e t u p   - D i r   " d i r 2 "  
  
         I t   " c r e a t e s   d i r e c t o r y   w h e n   c a l l e d   w i t h   n o   f i l e   c o n t e n t "   {  
                 " T e s t D r i v e : \ d i r 1 " . s h o u l d . e x i s t ( )  
         }  
  
         I t   " c r e a t e s   a n o t h e r   d i r e c t o r y   w h e n   c a l l e d   w i t h   n o   f i l e   c o n t e n t   a n d   d o e s n t   r e m o v e   f i r s t   d i r e c t o r y "   {  
                 $ r e s u l t   =   T e s t - P a t h   " T e s t D r i v e : \ d i r 2 "  
                 $ r e s u l t   =   $ r e s u l t   - a n d   ( T e s t - P a t h   " T e s t D r i v e : \ d i r 1 " )  
                 $ r e s u l t . s h o u l d . b e ( $ t r u e )  
         }  
 }  
  
 D e s c r i b e   " C r e a t e   n e s t e d   d i r e c t o r y   s t r u c t u r e "   {  
        
         S e t u p   - D i r   " p a r e n t / c h i l d "  
  
         I t   " c r e a t e s   p a r e n t   d i r e c t o r y "   {  
                 " T e s t D r i v e : \ p a r e n t " . s h o u l d . e x i s t ( )  
         }  
  
         I t   " c r e a t e s   c h i l d   d i r e c t o r y   u n d e r n e a t h   p a r e n t "   {  
                 " T e s t D r i v e : \ p a r e n t \ c h i l d " . s h o u l d . e x i s t ( )  
         }  
 }  
  
 D e s c r i b e   " C r e a t e   a   f i l e   w i t h   n o   c o n t e n t "   {  
  
         S e t u p   - F i l e   " f i l e "  
  
         I t   " c r e a t e s   f i l e "   {  
                 " T e s t D r i v e : \ f i l e " . s h o u l d . e x i s t ( )  
         }  
  
         I t   " a l s o   h a s   n o   c o n t e n t "   {  
                 $ r e s u l t   =   G e t - C o n t e n t   " T e s t D r i v e : \ f i l e "  
                 $ r e s u l t   =   ( $ r e s u l t   - e q   $ n u l l )  
                 $ r e s u l t . s h o u l d . b e ( $ t r u e )  
         }  
 }  
  
 D e s c r i b e   " C r e a t e   a   f i l e   w i t h   c o n t e n t "   {  
  
         S e t u p   - F i l e   " f i l e "   " f i l e   c o n t e n t s "  
  
         I t   " c r e a t e s   f i l e "   {  
                 " T e s t D r i v e : \ f i l e " . s h o u l d . e x i s t ( )  
         }  
  
         I t   " a d d s   c o n t e n t   t o   t h e   f i l e "   {  
                 $ r e s u l t   =   G e t - C o n t e n t   " T e s t D r i v e : \ f i l e "  
                 $ r e s u l t . s h o u l d . b e ( " f i l e   c o n t e n t s " )  
         }  
 }  
  
 