require 'prime'

maximumPrimeSum = 1000000

maximumConsecutiveCount = 21
maximumConsecutivePrimeNumber = 953

biggestPrimeNumber = maximumPrimeSum / maximumConsecutiveCount

prime = Prime.new

primeNumbers = []

primeNumber = prime.next

begin
  primeNumbers << primeNumber
  primeNumber = prime.next
end while primeNumber <= biggestPrimeNumber

# puts "#{primeNumbers}"

# the array contains the sum of all the previous element of each prime number
accumulativeSumOfPrimeNumbersArray = [2]

for i in 1...primeNumbers.length
  accumulativeSumOfPrimeNumbersArray << accumulativeSumOfPrimeNumbersArray[i - 1] + primeNumbers[i]
end

maximumIIndex = 0
maximumJIndex = 0

#puts "#{accumulativeSumOfPrimeNumbersArray}"

# loop on accumulativeSumOfPrimeNumbersArray and at each index try to subtract each combination of the previous prime numbers

for i in 1...accumulativeSumOfPrimeNumbersArray.length
  lastChechedNumber = accumulativeSumOfPrimeNumbersArray[i]

  for j in 0...(i - maximumConsecutiveCount)
    lastChechedNumber = lastChechedNumber - primeNumbers[j]

    if lastChechedNumber > maximumPrimeSum
      next
    end

    if Prime.prime?(lastChechedNumber)
      currentConsecutiveCount = i - j

      if currentConsecutiveCount > maximumConsecutiveCount
        maximumConsecutiveCount = currentConsecutiveCount
        maximumConsecutivePrimeNumber = lastChechedNumber

        maximumIIndex = i
        maximumJIndex = j

	# puts "maximumConsecutiveCount = #{maximumConsecutiveCount}"
	# puts "lastChechedNumber = #{lastChechedNumber}"
      end
    end
  end
end

# puts "maximumConsecutiveCount = #{maximumConsecutiveCount}"
# puts "maximumIIndex = #{maximumIIndex}"
# puts "maximumJIndex = #{maximumJIndex}"

sum = 0
for i in (maximumJIndex + 1)..maximumIIndex
  sum += primeNumbers[i]
end

puts "#{maximumConsecutivePrimeNumber} = #{primeNumbers[((maximumJIndex + 1)..maximumIIndex)].join(" + ")}"

puts "The longest sum of consecutive primes consists of #{maximumConsecutiveCount} term and is equals to = #{maximumConsecutivePrimeNumber}"

