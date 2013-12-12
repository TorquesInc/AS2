/**
 * タイムアウトを監視するクラス(AS2.0).
 * @author Hiromichi Yamada (Torques Inc.)
 * @example
 * <Frame 1>
 * import as.TimeoutObserver;
 * var timeoutObserver:TimeoutObserver = new TimeoutObserver();
 * <Button Start>
 * on (release) {
 * 	trace("test TimeoutObserver! - start");
 * 	_root.timeoutObserver.startTimer( 3, function(){trace("TimeOut !!!!")});
 * }
 * <Button Stop>
 * on (release) {
 * 	trace("test TimeoutObserver! - stop");
 * 	_root.timeoutObserver.stopTimer();
 * }
 */
class as.TimeoutObserver{
	
	var	_timerID:Number				= 0;	// インターバル ID
	var	_maxTime:Number				= 99;	// sec.
	var	_maxTimeCallback:Function	= null;
	var	_timeElapsed:Number			= 0;	// 経過時間(sec)
	
	public function TimeoutObserver()
	{
	}
	
	//------------------------------------------------------------
	/**
	 * タイムアウト監視を開始します
	 * @param	maxTime	タイムアウト時間(sec)
	 * @param	maxTimeCallback	タイムアウト時間になったときに呼び出す関数.
	 */
	//------------------------------------------------------------
	function startTimer( maxTime:Number, maxTimeCallback:Function ) :Void
	{
		_maxTime			= maxTime;
		_maxTimeCallback	= maxTimeCallback;
		
		_timerID		= setInterval(this, "timestep", 1000);// インターバルの設定.
	}
	
	//------------------------------------------------------------
	/**
	 * １秒毎に呼ばれる関数.
	 */
	//------------------------------------------------------------
	function timestep() :Void
	{
		_timeElapsed++;
		
		if ( _timeElapsed > _maxTime ) {
			clearInterval( _timerID );
			_timeElapsed	= 0;
			
			if ( _maxTimeCallback != null ) {
				_maxTimeCallback();
				
				_maxTimeCallback	= null;
			}
		}
	}
	
	//------------------------------------------------------------
	/**
	 * タイマーを止めるときに呼ぶ関数.
	 */
	//------------------------------------------------------------
	function stopTimer() :Void
	{
		clearInterval( _timerID );
		_timerID			= 0;
		_maxTime			= 0;
		_maxTimeCallback	= null;
		_timeElapsed		= 0;
	}
}