$ g l o b a l : T e s t D r i v e   =   " $ e n v : T e m p \ p e s t e r "  
  
 f u n c t i o n   I n i t i a l i z e - S e t u p ( )   {  
         i f   ( T e s t - P a t h   T e s t D r i v e : )   {   r e t u r n   }  
  
         N e w - I t e m   - N a m e   p e s t e r   - P a t h   $ e n v : T e m p   - T y p e   C o n t a i n e r   - F o r c e   |   O u t - N u l l  
         N e w - P S D r i v e   - N a m e   T e s t D r i v e   - P S P r o v i d e r   F i l e S y s t e m   - R o o t   " $ ( $ e n v : T e m p ) \ p e s t e r "   - S c o p e   G l o b a l   |   O u t - N u l l  
 }  
  
 f u n c t i o n   S e t u p ( [ s w i t c h ]   $ D i r ,   [ s w i t c h ]   $ F i l e ,   $ P a t h ,   $ C o n t e n t   =   " " )   {  
         I n i t i a l i z e - S e t u p  
  
         i f   ( $ D i r )   {  
                 N e w - I t e m   - N a m e   $ P a t h   - P a t h   T e s t D r i v e :   - T y p e   C o n t a i n e r   - F o r c e   |   O u t - N u l l  
         }   e l s e i f   ( $ F i l e )   {  
                 $ C o n t e n t   |   N e w - I t e m   - N a m e   $ P a t h   - P a t h   T e s t D r i v e :   - T y p e   F i l e   - F o r c e   |   O u t - N u l l  
         }  
 }  
 