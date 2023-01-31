import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import jwt_decode from 'jwt-decode';

import { UsersService } from './users/users.service';

interface DecodedToken {
  email: string;
  // cualquier otra propiedad incluida en el token
}

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(private readonly usersService: UsersService) {}
  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest();
    const authorization = request.headers.authorization;


    if (!authorization) {
      return false;
    }

    const token = authorization.split(' ')[1];

    try {
      const decoded = jwt_decode(token) as DecodedToken;
      if (this.usersService.findOne({email: decoded.email})) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }
}
