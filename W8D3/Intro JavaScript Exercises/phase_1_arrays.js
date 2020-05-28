Array.prototype.uniq = function() {
    let result = [];

    for(let i = 0; i < this.length; i++){
        if (!result.includes(this[i])){
            result.push(this[i])
        }
    }

    return result;
}

console.log([1,2,2,3,3,3].uniq());

Array.prototype.twoSum = function() {
    let result = [];

    for (let i = 0; i < this.length; i++) {
        for (let j = i + 1; j < this.length; j++) {
            if (this[i] + this[j] === 0) {
                result.push([i, j]);
            }
        }
    }
    return result;
}

// console.log([1, 2, 2, 3, -2, -1].twoSum());

Array.prototype.transpose = function() {
    let result = new Array (this[0].length).fill([]).map(el => new Array (this[0].length).fill([])) // Similar to Ruby's Array.new(self.length) {Array.new}

    for(let i = 0; i < this.length; i++){
        for(let j = 0; j < this[i].length; j++){
            result[j].push(this[i][j])
        }
    }

    return result;
}
