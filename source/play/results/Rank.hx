package play.results;

class Rank
{

        /**
         * The rank as a string value
         */
        public var RANK:String = 'perfect';

        /**
         * Initalizing the rank
         * @param percent Rank percentage
         */
        public function new(percent:Float = 0.0) {
                RANK = grade(percent);
        }

        /**
         * Returns a rank depending on the `percent`.
         * @param percent Rank percentage
         */
        public function grade(percent:Float = 0.0)
        {
                if (percent == 100) return 'perfect';
		if (percent >= 90) return 'excellent';
		if (percent >= 80) return 'great';
		if (percent >= 60) return 'good';
		if (percent >= 10) return 'bad';

                return 'awful';
        }
        
}